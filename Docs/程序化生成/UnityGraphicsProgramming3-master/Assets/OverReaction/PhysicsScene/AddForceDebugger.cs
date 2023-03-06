using UnityEngine;

public class AddForceDebugger : MonoBehaviour
{
    #region Field

    protected Rigidbody rigidBody;

    public Vector3 addForce = Vector3.one * 10;

    public KeyCode xForceKey = KeyCode.RightArrow;

    public KeyCode xiForceKey = KeyCode.LeftArrow;

    public KeyCode yForceKey = KeyCode.UpArrow;

    public KeyCode yiForceKey = KeyCode.DownArrow;

    #endregion Field

    private void Start()
    {
        this.rigidBody = base.GetComponent<Rigidbody>();

        if (this.rigidBody == null)
        {
            this.enabled = false;
        }
    }

    void Update ()
    {
        if (Input.GetKey(this.xForceKey))
        {
            this.rigidBody.AddForce(Vector3.right * addForce.x);
        }
        if (Input.GetKey(this.xiForceKey))
        {
            this.rigidBody.AddForce(Vector3.left * addForce.x);
        }
        if (Input.GetKey(this.yForceKey))
        {
            this.rigidBody.AddForce(Vector3.up * addForce.y);
        }
        if (Input.GetKey(this.yiForceKey))
        {
            this.rigidBody.AddForce(Vector3.down * addForce.y);
        }
    }
}