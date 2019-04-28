//Part of this script is from https://learn.unity.com/tutorial/translate-and-rotate?projectId=5c8920b4edbc2a113b6bc26a#5c8a44c2edbc2a001f47ce1e
using UnityEngine;
using System.Collections;

public class TransformFunctions: MonoBehaviour
{
	void Update()
	{
        transform.Translate(Vector3.forward * Time.deltaTime);
	}
}
