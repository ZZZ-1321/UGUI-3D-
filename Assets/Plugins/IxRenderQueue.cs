using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IxRenderQueue : MonoBehaviour
{

    //TemplateIOSFunctionMethod

    public int _RenderQueue = 2000;

    //TemplateIOSFunctionMethod

    private static List<Renderer> ms_listForR = new List<Renderer>();

	// Use this for initialization
	void Start ()
    {
        int i;
        int j;
        Material[] arrMat;
        Material kMat;

        //Renderer[] arrR = gameObject.GetComponentsInChildren<Renderer>(true);		
        gameObject.GetComponentsInChildren<Renderer>(true, ms_listForR);
        for ( i = 0; i < ms_listForR.Count; i++ )
        {
            ParticleSystemRenderer kPSR = ms_listForR[i] as ParticleSystemRenderer;
            if ( kPSR != null )
            {
                kMat = kPSR.material;
                if (kMat != null )
                {
                    kMat.renderQueue = _RenderQueue;
                    kPSR.material = kMat;
                }
            }
            else
            {
                arrMat = ms_listForR[i].materials;
                for (j = 0; j < arrMat.Length; j++)
                {
                    if (arrMat[j] == null)
                    {
                        continue;
                    }

                    arrMat[j].renderQueue = _RenderQueue;
                }
                ms_listForR[i].materials = arrMat;
            }            
        }
	}

    //TemplateIOSFunctionMethod

	// Update is called once per frame
	void Update ()
    {
		
	}
}
