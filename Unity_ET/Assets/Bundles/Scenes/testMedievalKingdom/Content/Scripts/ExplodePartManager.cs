using System.Collections;
using UnityEngine;

public sealed class ExplodePartManager : MonoBehaviour
{
	private enum AnimationDirection
	{
		Forward,
		Reverse,
	}

	[SerializeField]
	private float m_animationTime;

	[SerializeField]
	private KeyCode m_key;

	private float m_animationProgress;
	private AnimationDirection m_currentDirection;
	private ExplodePart[] m_explodeParts;

	#region Unity core events.
	private void Awake()
	{
		m_animationProgress = 0f;
		m_currentDirection = AnimationDirection.Reverse;
		m_explodeParts = GetComponentsInChildren<ExplodePart>(true);
	}

	private void Update()
	{
		if (Input.GetKeyUp(m_key))
		{
			m_currentDirection = m_currentDirection == AnimationDirection.Forward ?
				AnimationDirection.Reverse : AnimationDirection.Forward;

			StopCoroutine("PlayExplodeAnimation");
			StartCoroutine("PlayExplodeAnimation");
		}
	}
	#endregion //Unity core events.

	#region Class functions.
	private void ApplyExplodeOffset(float offset)
	{
		foreach (ExplodePart part in m_explodeParts)
		{
			part.ApplyExplodeOffset(offset);
		}
	}

	private float EaseInOutSine(float value)
	{
		return -0.5f * (Mathf.Cos(Mathf.PI * value) - 1f);
	}

	private IEnumerator PlayExplodeAnimation()
	{
		do
		{
			ApplyExplodeOffset(EaseInOutSine(m_animationProgress / m_animationTime));
			yield return null;

			m_animationProgress += m_currentDirection == AnimationDirection.Forward ? Time.deltaTime : -Time.deltaTime;
		}
		while (m_animationProgress > 0f && m_animationProgress < m_animationTime);

		m_animationProgress = Mathf.Clamp(m_animationProgress, 0f, m_animationTime);
		ApplyExplodeOffset(EaseInOutSine(m_animationProgress / m_animationTime));
	}
	#endregion //Class functions.
}
