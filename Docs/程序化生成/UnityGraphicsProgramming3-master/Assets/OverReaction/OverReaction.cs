using UnityEngine;

// Reference:
// http://the12principles.tumblr.com/

public class OverReaction : MonoBehaviour
{
    #region Field

    public float maxDeformScale = 3f;
    public float minDeformScale = 0.2f;
    public float deformPower    = 5f;
    public float undeformPower  = 0.5f;

    protected new Transform transform;

    protected Mesh baseMesh;
    protected Vector3[] baseVertices;
    protected Bounds baseBounds;

    protected Vector3 prevPosition;
    protected Vector3 crntMove;
    protected Vector3 prevMove;
    protected Vector3 moveEnergy;
    protected Vector3 deformEnergy;

    #endregion Field

    #region Property

    public Vector3 CrntMove     { get { return this.crntMove;     } }
    public Vector3 MoveEnergy   { get { return this.moveEnergy;   } }
    public Vector3 DeformEnergy { get { return this.deformEnergy; } }

    #endregion Property

    #region Method

    protected void Awake()
    {
        this.transform = base.transform;

        this.baseMesh     = base.GetComponent<MeshFilter>().mesh;
        this.baseVertices = this.baseMesh.vertices;
        this.baseBounds   = this.baseMesh.bounds;

        this.prevPosition = this.transform.position;
        this.crntMove = Vector3.zero;
        this.prevMove = Vector3.zero;
        this.moveEnergy = Vector3.zero;
        this.deformEnergy = Vector3.zero;
    }

    protected void OnDrawGizmos()
    {
        if (this.transform == null) 
        {
            return;
        }

        Color prevColor = Gizmos.color;
        Matrix4x4 prevMatrix = Gizmos.matrix;

        Gizmos.color = Color.red;
        Gizmos.DrawLine(this.transform.position,
                        this.transform.position + (this.crntMove.normalized * 3));

        Gizmos.color = Color.blue;
        Gizmos.DrawLine(this.transform.position,
                        this.transform.position + (this.moveEnergy.normalized * 3));

        Gizmos.color = prevColor;
        Gizmos.matrix = prevMatrix;
    }

    protected void FixedUpdate()
    {
        // NOTE:
        // Use FixedUpdate instead Update or anyothers.
        // PhysX object's Transform might not be updated in these function.
        // https://answers.unity.com/questions/407035/are-unitys-and-physxs-frame-rates-in-sync.html

        this.crntMove = this.transform.position - this.prevPosition;

        UpdateMoveEnergy();
        UpdateDeformEnergy();
        DeformMesh();

        this.prevPosition = this.transform.position;
        this.prevMove = this.crntMove;
    }

    protected void UpdateMoveEnergy()
    {
        this.moveEnergy = new Vector3()
        {
            x = UpdateMoveEnergy(this.crntMove.x, this.prevMove.x, this.moveEnergy.x),
            y = UpdateMoveEnergy(this.crntMove.y, this.prevMove.y, this.moveEnergy.y),
            z = UpdateMoveEnergy(this.crntMove.z, this.prevMove.z, this.moveEnergy.z),
        };
    }

    protected float UpdateMoveEnergy(float crntMove, float prevMove, float moveEnergy)
    {
        int crntMoveSign = Sign(crntMove);
        int prevMoveSign = Sign(prevMove);
        int moveEnergySign = Sign(moveEnergy);

        if (crntMoveSign == 0)
        {
            return moveEnergy * this.undeformPower;
        }

        if (crntMoveSign != prevMoveSign)
        {
            return moveEnergy - crntMove;
        }

        if (crntMoveSign != moveEnergySign)
        {
            return moveEnergy + crntMove;
        }

        if (crntMoveSign < 0)
        {
            return Mathf.Min(crntMove * this.deformPower, moveEnergy * this.undeformPower);
        }
        else
        {
            return Mathf.Max(crntMove * this.deformPower, moveEnergy * this.undeformPower);
        }
    }

    protected void UpdateDeformEnergy()
    {
        float deformEnergyVertical = this.moveEnergy.magnitude
                                   * Vector3.Dot(this.moveEnergy.normalized, this.crntMove.normalized);

        float deformEnergyHorizontalRatio = deformEnergyVertical / this.maxDeformScale;
        float deformEnergyHorizontal = 1 - deformEnergyHorizontalRatio;

        if (deformEnergyVertical < 0)
        {
            deformEnergyVertical = deformEnergyHorizontalRatio;
        }

        deformEnergyVertical = 1 + deformEnergyVertical;

        deformEnergyVertical = Mathf.Clamp(deformEnergyVertical,
                                           this.minDeformScale,
                                           this.maxDeformScale);

        deformEnergyHorizontal = Mathf.Clamp(deformEnergyHorizontal,
                                             this.minDeformScale,
                                             this.maxDeformScale);

        this.deformEnergy = new Vector3(deformEnergyHorizontal,
                                        deformEnergyVertical,
                                        deformEnergyHorizontal);
    }

    protected void DeformMesh()
    {
        Vector3[] deformedVertices = new Vector3[this.baseVertices.Length];
        Quaternion crntRotation  = this.transform.localRotation;
        Quaternion crntRotationI = Quaternion.Inverse(crntRotation);
        Quaternion moveEnergyRotation  = Quaternion.FromToRotation(Vector3.up, this.moveEnergy.normalized);
        Quaternion moveEnergyRotationI = Quaternion.Inverse(moveEnergyRotation);

        for (int i = 0; i < this.baseVertices.Length; i++)
        {
            deformedVertices[i] = this.baseVertices[i];
            deformedVertices[i] = crntRotation * deformedVertices[i];
            deformedVertices[i] = moveEnergyRotationI * deformedVertices[i];
            deformedVertices[i] = new Vector3(deformedVertices[i].x * this.deformEnergy.x,
                                              deformedVertices[i].y * this.deformEnergy.y,
                                              deformedVertices[i].z * this.deformEnergy.z);
            deformedVertices[i] = moveEnergyRotation * deformedVertices[i];
            deformedVertices[i] = crntRotationI * deformedVertices[i];
        }

        this.baseMesh.vertices = deformedVertices;
    }

    public static int Sign(float value)
    {
        return value == 0 ? 0 : (value > 0 ? 1 : -1);
    }

    #endregion Method
}