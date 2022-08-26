HA$PBExportHeader$w_error_enviosap.srw
forward
global type w_error_enviosap from window
end type
type cb_2 from commandbutton within w_error_enviosap
end type
type cb_1 from commandbutton within w_error_enviosap
end type
type dw_inf from datawindow within w_error_enviosap
end type
end forward

global type w_error_enviosap from window
integer width = 2743
integer height = 1140
boolean titlebar = true
string title = "Registro de Errores llamado SAP"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12639424
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_inf dw_inf
end type
global w_error_enviosap w_error_enviosap

on w_error_enviosap.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_inf=create dw_inf
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_inf}
end on

on w_error_enviosap.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_inf)
end on

event open;String ls_error
ls_error = message.stringparm 

dw_inf.insertrow(0)

dw_inf.object.error[1] = ls_error







end event

type cb_2 from commandbutton within w_error_enviosap
integer x = 539
integer y = 932
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

type cb_1 from commandbutton within w_error_enviosap
integer x = 69
integer y = 932
integer width = 343
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;CLOSE(Parent)
end event

type dw_inf from datawindow within w_error_enviosap
integer x = 46
integer y = 60
integer width = 2619
integer height = 808
integer taborder = 10
string title = "none"
string dataobject = "d_error_sap"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

