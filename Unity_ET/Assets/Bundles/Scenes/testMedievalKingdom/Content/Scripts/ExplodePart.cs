using System;
using UnityEngine;

public sealed class ExplodePart : MonoBehaviour
{
	[Serializable]
	public class TransformParams
	{
		public Vector3 Position;
		public Quaternion Rotation;
		public Vector3 Scale;
	}

	public TransformParams FinalTransform
	{
		get
		{
			return m_finalTransform;
		}

		set
		{
			m_finalTransform = value;
		}
	}

	public TransformParams InitialTransform
	{
		get
		{
			return m_initialTransform;
		}

		set
		{
			m_initialTransform = value;
		}
	}

	[SerializeField]
	private TransformParams m_finalTransform;

	[SerializeField]
	private TransformParams m_initialTransform;

	#region Unity core events.
	#endregion //Unity core events.

	#region Class functions.
	public void ApplyExplodeOffset(float offset)
	{
		Transform cachedTransform = transform;
		offset = Mathf.Clamp01(offset);

		cachedTransform.localPosition = Vector3.Lerp(InitialTransform.Position, FinalTransform.Position, offset);
		cachedTransform.localRotation = Quaternion.Slerp(InitialTransform.Rotation, FinalTransform.Rotation, offset);
		cachedTransform.localScale = Vector3.Lerp(InitialTransform.Scale, FinalTransform.Scale, offset);
	}
	#endregion //Class functions.
}
