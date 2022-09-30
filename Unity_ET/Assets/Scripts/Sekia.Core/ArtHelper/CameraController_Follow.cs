using UnityEngine;

public class CameraController_Follow : MonoBehaviour
{
    [Header("Initial Values")]
    public Transform followedTarget = null;
    [SerializeField] private Vector3 desiredPosition = Vector3.zero;
    [SerializeField] private float desiredYAngle = 0f;
    [SerializeField] private float desiredXAngle = 0f;
    [SerializeField] private float zoomValue = 1f;

    [Header("InputAxisName")]
    [SerializeField] private string rotationAxisName = "";
    [SerializeField] private string zoomAxisName = "Mouse ScrollWheel";

    [Header("Control")]
    [SerializeField] private float movementLerpSpeed = 5f;
    [SerializeField] private float rotationLerpSpeed = 5f;
    [SerializeField] private float rotationInputSensitivity = 1f;
    [SerializeField] private float zoomInputSensitivity = 1f;
    [SerializeField] private AnimationCurve zoomXAngleCurve = AnimationCurve.Linear(0, 0, 1, 60);
    [SerializeField] private AnimationCurve zoomHeightCurve = AnimationCurve.Linear(0, 0, 1, 15);
    [SerializeField] private AnimationCurve zoomDistanceCurve = AnimationCurve.Linear(0, 2, 1, 10);

    private void Start()
    {
        var rotation = transform.eulerAngles;
        rotation.x = rotation.x.ClampAngle();
        rotation.y = rotation.y.ClampAngle();
        desiredYAngle = rotation.y;
        zoomValue = Mathf.Clamp01(zoomValue);
        rotation.x = zoomXAngleCurve.Evaluate(zoomValue);
        desiredXAngle = rotation.x;
        transform.eulerAngles = rotation;
    }

    private void Update()
    {
        HandleInput();
    }

    private void LateUpdate()
    {
        if (followedTarget)
            UpdateTransform();
    }

    private void HandleInput()
    {
        if (!string.IsNullOrEmpty(rotationAxisName))
            Rotate(Input.GetAxis(rotationAxisName) * rotationInputSensitivity);

        if (!string.IsNullOrEmpty(zoomAxisName))
            Zoom(Input.GetAxis(zoomAxisName) * zoomInputSensitivity);
        else
            Zoom(0);
    }

    private void Rotate(float direction)
    {
        desiredYAngle = (desiredYAngle + direction).ClampAngle();
    }

    private void Zoom(float value)
    {
        zoomValue = Mathf.Clamp01(zoomValue + value);
        desiredPosition.y = zoomHeightCurve.Evaluate(zoomValue);
        desiredXAngle = zoomXAngleCurve.Evaluate(zoomValue);
    }

    private void UpdateTransform()
    {
        // Lerp actual rotation to the desired value.
        var targetRotation = Quaternion.Euler(desiredXAngle, desiredYAngle, 0);
        transform.rotation = Quaternion.Slerp(transform.rotation, targetRotation, rotationLerpSpeed * Time.deltaTime);

        // Set desired position to target's position if we are following something.
        desiredPosition.x = followedTarget.position.x;
        desiredPosition.z = followedTarget.position.z;

        // Move camera back and rotate.
        var offsetDistance = zoomDistanceCurve.Evaluate(zoomValue);
        var offsetYRotation = Quaternion.Euler(0, desiredYAngle, 0);
        var offsetPosition = offsetYRotation * (Vector3.forward * offsetDistance);
        desiredPosition -= offsetPosition;
        desiredPosition.y += followedTarget.position.y;

        // Lerp to the desired position.
        transform.position = Vector3.Lerp(transform.position, desiredPosition, movementLerpSpeed * Time.deltaTime);
    }
}
