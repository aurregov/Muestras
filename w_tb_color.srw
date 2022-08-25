HA$PBExportHeader$w_tb_color.srw
forward
global type w_tb_color from w_simple
end type
end forward

global type w_tb_color from w_simple
integer width = 3049
integer height = 2156
string title = "Mantenimiento de Colores SAP"
boolean minbox = false
end type
global w_tb_color w_tb_color

type variables
 
end variables

event open;call super::open;/*
* ============================================================================
* MODIFICADO: Diciembre 22 de 2011 - ohlondon
* ----------------------------------------------------------------------------
* Mantenimiento de colores tb_color en producto@crypro01 de sabdbs01
* ============================================================================
*/
m_base lm_menu

lm_menu = This.MenuId

lm_menu.m_archivo.m_guardarcomo.visible = TRUE
lm_menu.m_archivo.m_guardarcomo.toolbaritemvisible = TRUE
 
this.x = 1
this.y = 1
end event

on w_tb_color.create
call super::create
end on

on w_tb_color.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_general from w_simple`dw_general within w_tb_color
integer y = 60
integer width = 2907
integer height = 1876
string dataobject = "dgr_tb_color"
end type

event dw_general::ue_update;Long         ll_i,ll_n
dwItemStatus l_status

If This.of_CompleteData() Then
	//Tambien actualizar fecha,usuario,instancia
	If Not n_cst_application.of_SelectServer(n_cst_application.itr_appl,&
													 idt_fecha,is_usuario,is_instancia) Then
		Return
	End If
	ll_n = This.RowCount()
	For ll_i = 1 To ll_n
		l_status = This.GetItemStatus(ll_i,0,Primary!)
		If l_status <> NotModified! Then
			//si el DataWindow tiene fe_actualizacion,usuario,instancia
			//entonces actualizarlas
			If This.of_ExistColumn('fh_actualizacion') Then
				This.SetItem(ll_i,'fh_actualizacion',idt_fecha)
			End If
			If This.of_ExistColumn('usuario') Then
				This.SetItem(ll_i,'usuario',is_usuario)
			End If	
		End If
	Next
	If This.Update(True) = 1 Then
		Commit Using n_cst_application.itr_appl;
		MessageBox("$$HEX1$$a100$$ENDHEX$$Grabaci$$HEX1$$f300$$ENDHEX$$n Existosa!","Los datos se han registrado satisfactoriamente.")
	Else
		RollBack Using n_cst_application.itr_appl;
		MessageBox("Error","$$HEX1$$a100$$ENDHEX$$Se ha producido un error actualizando los datos!",StopSign!)
	End If
End If	
This.SetFocus()
end event

type gb_general from w_simple`gb_general within w_tb_color
integer x = 27
integer y = 4
integer width = 2971
integer height = 1956
end type

