/*
 *
 *	This is a simple program that illustrates how to call the MATLAB
 *	Engine functions from NetSim C Code.
 *
 */
#include <windows.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "engine.h"
#include "mat.h"
#include "mex.h"



char buf[100];
Engine *ep;
int status;
mxArray *h=NULL, *i=NULL, *j=NULL,*k=NULL,*k1=NULL,*k2=NULL;
mxArray *out;
double *result;

double fn_matlab_init()
{
	/*
	 * Start the MATLAB engine 
	 */
	if (!(ep = engOpen(NULL))) {
		MessageBox ((HWND)NULL, (LPCWSTR)"Can't start MATLAB engine", 
			(LPCWSTR) "MATLAB_Interface.c", MB_OK);
		exit(-1);
	}
	engEvalString(ep,"desktop");

	return 0;
}

double fn_netsim_matlab_run(double simulation_time, double event_time,double sink_arrival_Time, int flag)
{
	
	//write your own implementation here

	sprintf(buf,"k=NetSim_MATLAB_RUN(%f,%f,%f,%d)",simulation_time,event_time,sink_arrival_Time,flag);
	fprintf(stderr,"k=%f\n",result);
	status=engEvalString(ep,buf);
	out=engGetVariable(ep,"k");
	result=mxGetPr(out);
	
	

	return *result;
}




double fn_netsim_matlab_Finish()
{
	status=engEvalString(ep,"exit");
	
	return 0;
}

