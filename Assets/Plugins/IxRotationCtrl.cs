using System;
using System.Collections.Generic;
using UnityEngine;

public class IxRotationCtrl : MonoBehaviour
{

    public Vector3 _Axis = Vector3.up;
    public float _RotSpeed = 90.0f;
    public bool _Revolution = false;

    //public Vector3 _RevolutionPoint = Vector3.zero;
    public Transform _RevolutionPoint;

    private Transform _TRS;

    void Start()
    {
        _TRS = transform;       
    }

    void Update()
    {
        float fRotAngle = _RotSpeed * Time.deltaTime;
        if ( _Revolution )
        {
            Vector3 vec3Center = Vector3.zero;
            if ( _RevolutionPoint != null )
            {
                vec3Center = _RevolutionPoint.position;
            }
            _TRS.RotateAround(vec3Center, _Axis, fRotAngle);
        }
        else
        {
            _TRS.Rotate(_Axis, fRotAngle, Space.Self);
        }
    }
}

