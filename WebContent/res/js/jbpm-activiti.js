'use strict';

var JBPMN = JBPMN || {};

JBPMN.APPROOT = (function(win){
	var hostPath = win.location.href.substring(0, win.location.href.indexOf(win.location.pathname));
	var projectName = win.location.pathname.substring(0, win.location.pathname.substr(1).indexOf('/') + 1);
	return hostPath + projectName;
}(window));

JBPMN.BPMNROOT = JBPMN.APPROOT + "/act/bpm/";
JBPMN.SERVICEROOT = JBPMN.APPROOT + "/act/service/";
JBPMN.RESTROOT = JBPMN.APPROOT + "/act/rest/";
