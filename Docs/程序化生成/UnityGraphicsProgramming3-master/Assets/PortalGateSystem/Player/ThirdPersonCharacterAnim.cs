using UnityEngine;
using UnityStandardAssets.Characters.FirstPerson;

namespace PortalGateSystem
{
	[RequireComponent(typeof(Animator))]
	public class ThirdPersonCharacterAnim : MonoBehaviour
    {
		[SerializeField] float m_RunCycleLegOffset = 0.2f; //specific to the character in sample assets, will need to be modified to work with others
		[SerializeField] float m_AnimSpeedMultiplier = 1f;
		//[SerializeField] float m_GroundCheckDistance = 0.1f;

		[SerializeField] Rigidbody m_Rigidbody;
		Animator m_Animator;
		bool m_IsGrounded;
		//float m_OrigGroundCheckDistance;
		const float k_Half = 0.5f;
		float m_TurnAmount = 0f;
		float m_ForwardAmount;
		Vector3 m_GroundNormal = Vector3.up;
        //float m_CapsuleHeight;
        //Vector3 m_CapsuleCenter;
        //CapsuleCollider m_Capsule;
        bool m_Crouching = false;

        [SerializeField] CharacterController m_charaController;


        void Start()
		{
			m_Animator = GetComponent<Animator>();
			//m_Capsule = GetComponent<CapsuleCollider>();
			//m_CapsuleHeight = m_Capsule.height;
			//m_CapsuleCenter = m_Capsule.center;

			m_Rigidbody.constraints = RigidbodyConstraints.FreezeRotationX | RigidbodyConstraints.FreezeRotationY | RigidbodyConstraints.FreezeRotationZ;
			//m_OrigGroundCheckDistance = m_GroundCheckDistance;
		}


        private void Update()
        {
            Move(m_charaController.velocity / 10f, false, false);
        }


        public void Move(Vector3 move, bool crouch, bool jump)
        {

            // convert the world relative moveInput vector into a local-relative
            // turn amount and forward amount required to head in the desired
            // direction.
            if (move.magnitude > 1f) move.Normalize();
            move = transform.InverseTransformDirection(move);
            //CheckGroundStatus();
            m_IsGrounded = m_charaController.isGrounded;
            move = Vector3.ProjectOnPlane(move, m_GroundNormal);
            //m_TurnAmount = Mathf.Atan2(move.x, move.z);
            //m_ForwardAmount = move.z;
            m_ForwardAmount = (new Vector2(move.x, move.z)).magnitude;

            //ApplyExtraTurnRotation();

            /*
            // control and velocity handling is different when grounded and airborne:
            if (m_IsGrounded)
            {
                HandleGroundedMovement(crouch, jump);
            }
            else
            {
                HandleAirborneMovement();
            }

            ScaleCapsuleForCrouching(crouch);
            PreventStandingInLowHeadroom();
            */

            // send input and other state parameters to the animator
            UpdateAnimator(move);
        }


        void UpdateAnimator(Vector3 move)
		{
			// update the animator parameters
			m_Animator.SetFloat("Forward", m_ForwardAmount, 0.1f, Time.deltaTime);
			m_Animator.SetFloat("Turn", m_TurnAmount, 0.1f, Time.deltaTime);
			m_Animator.SetBool("Crouch", m_Crouching);
			m_Animator.SetBool("OnGround", m_IsGrounded);
			if (!m_IsGrounded)
			{
				m_Animator.SetFloat("Jump", m_Rigidbody.velocity.y);
			}

			// calculate which leg is behind, so as to leave that leg trailing in the jump animation
			// (This code is reliant on the specific run cycle offset in our animations,
			// and assumes one leg passes the other at the normalized clip times of 0.0 and 0.5)
			float runCycle =
				Mathf.Repeat(
					m_Animator.GetCurrentAnimatorStateInfo(0).normalizedTime + m_RunCycleLegOffset, 1);
			float jumpLeg = (runCycle < k_Half ? 1 : -1) * m_ForwardAmount;
			if (m_IsGrounded)
			{
				m_Animator.SetFloat("JumpLeg", jumpLeg);
			}

			// the anim speed multiplier allows the overall speed of walking/running to be tweaked in the inspector,
			// which affects the movement speed because of the root motion.
			if (m_IsGrounded && move.magnitude > 0)
			{
				m_Animator.speed = m_AnimSpeedMultiplier;
			}
			else
			{
				// don't use that while airborne
				m_Animator.speed = 1;
			}
		}


#if false
        void CheckGroundStatus()
		{
			RaycastHit hitInfo;
#if UNITY_EDITOR
			// helper to visualise the ground check ray in the scene view
			Debug.DrawLine(transform.position + (Vector3.up * 0.1f), transform.position + (Vector3.up * 0.1f) + (Vector3.down * m_GroundCheckDistance), Color.red);
#endif
			// 0.1f is a small offset to start the ray from inside the character
			// it is also good to note that the transform position in the sample assets is at the base of the character
			if (Physics.Raycast(transform.position + (Vector3.up * 0.1f), Vector3.down, out hitInfo, m_GroundCheckDistance))
			{
				m_GroundNormal = hitInfo.normal;
				m_IsGrounded = true;
				//m_Animator.applyRootMotion = true;
			}
			else
			{
				m_IsGrounded = false;
				m_GroundNormal = Vector3.up;
				//m_Animator.applyRootMotion = false;
			}
		}
#endif
	}
}
