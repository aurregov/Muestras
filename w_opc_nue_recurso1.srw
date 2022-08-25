HA$PBExportHeader$w_opc_nue_recurso1.srw
$PBExportComments$Permite seleccionar adicionalmente un recurso~r~nPara las nuevas medidas
forward
global type w_opc_nue_recurso1 from w_response
end type
type cb_buscar from commandbutton within w_opc_nue_recurso1
end type
type dw_consulta from u_dw_application within w_opc_nue_recurso1
end type
type cb_1 from commandbutton within w_opc_nue_recurso1
end type
type cb_aceptar from commandbutton within w_opc_nue_recurso1
end type
type dw_1 from u_dw_application within w_opc_nue_recurso1
end type
type gb_1 from groupbox within w_opc_nue_recurso1
end type
type gb_2 from u_gb_base within w_opc_nue_recurso1
end type
end forward

global type w_opc_nue_recurso1 from w_response
integer x = 0
integer y = 0
integer width = 3616
integer height = 1364
string title = "Selecci$$HEX1$$f300$$ENDHEX$$n de muestras"
cb_buscar cb_buscar
dw_consulta dw_consulta
cb_1 cb_1
cb_aceptar cb_aceptar
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
end type
global w_opc_nue_recurso1 w_opc_nue_recurso1

type variables
String is_where, is_select

DataWindowChild idc_talla

long il_fila

n_cst_param iou_param
end variables

forward prototypes
public function integer of_filasel (long a_fila)
public function integer of_recuperar (string a_where)
public function integer of_retorno ()
end prototypes

public function integer of_filasel (long a_fila);//////////////////////////////////////////////////////////////////////////
// JUAN FERNANDO VASQUEZ DUQE 
// Viernes 06 de Diciembre de 2002 HORA 16:26:14:453
// 
// Cuando se selecciona una fila
//////////////////////////////////////////////////////////////////////////

il_fila=a_fila

dw_consulta.SelectRow(0,False)
dw_consulta.SelectRow(il_fila,True)


Return 1

end function

public function integer of_recuperar (string a_where);//"m_recursos_tj.co_fabrica ) and ("
String ls_sel1,ls_modString
long ll_pos,ll_res,ll_tot,i,ll_recurso,ll_fabrica, ll_long, ll_pos2
n_cst_comun lo_c	

If Right(a_where,1)=")" Then
	ls_sel1=dw_consulta.Describe("DataWindow.Table.Select")

	ll_pos=pos(ls_sel1,"dt_muestras.co_talla = dt_med_mue.co_talla )")
	
	If ll_pos>0 Then
		ls_Sel1=Left(ls_sel1, ll_pos -1)
		ll_pos=pos(a_where," and (")		
		ll_long = len(a_where)
		IF ll_pos > 0 THEN
			a_where = Right(a_where, ll_long - 6)
		END IF

		
	End If
	
	ls_modString="DataWindow.Table.Select='" &
		+ ls_sel1 + a_where + "'"
	
	dw_consulta.Modify(ls_modString)
	
End If
il_fila=0

ll_tot=dw_consulta.Retrieve()

//For i=1 To ll_tot
//	ll_fabrica=dw_consulta.GetItemNumber(i,"co_fabrica")
//	ll_recurso=dw_consulta.GetItemNUmber(i,"co_recurso")
//	ll_res=lo_c.of_nombrerecursotj(ll_recurso /*long a_recurso*/,&
//											 n_cst_application.itr_appl/*transaction a_transaction */)
//											 
//	If ll_res>0 Then
//		dw_consulta.SetItem(i,"de_recurso",lo_c.of_getString(1))
//	End If
//Next
//
If dw_consulta.RowCount()=1 then
	of_filaSel(1)
End If

dw_consulta.SetFocus()

Return 1
end function

public function integer of_retorno ();//////////////////////////////////////////////////////////////////////////
// JUAN FERNANDO VASQUEZ DUQE 
// Viernes 08 de Agosto de 2003 HORA 09:43:54:053
// 
// Se envia la informaci$$HEX1$$f300$$ENDHEX$$n hasta el recurso
//////////////////////////////////////////////////////////////////////////


If dw_1.AcceptText()<>1 Then
	MessageBox("Advertencia!","Datos no v$$HEX1$$e100$$ENDHEX$$lidos.",StopSign!)
	Return -1
End If

If il_fila<=0 then
	MessageBox("Advertencia!","Debe seleccionar una muestra.",StopSign!)
	Return -1
End If


iou_param.il_vector[1] = dw_consulta.GetItemNumber(il_fila,"co_fabrica")
iou_param.il_vector[2] = dw_consulta.GetItemNumber(il_fila,"co_linea")
iou_param.il_vector[3] = dw_consulta.GetItemNumber(il_fila,"co_muestra")
iou_param.il_vector[4] = dw_consulta.GetItemNumber(il_fila,"co_talla")
iou_param.il_vector[5] = dw_consulta.GetItemNumber(il_fila,"co_tipoprod")
iou_param.il_vector[6] = dw_consulta.GetItemNumber(il_fila,"co_diseno")
iou_param.il_vector[7] = dw_consulta.GetItemNumber(il_fila,"co_grupo_tlla")

iou_param.is_vector[1]=is_where

n_cst_application.il_fabMue=dw_consulta.GetItemNumber(il_fila,"co_fabrica")
n_cst_application.il_lineaMue=dw_consulta.GetItemNumber(il_fila,"co_linea")
n_cst_application.il_muestra=dw_consulta.GetItemNumber(il_fila,"co_muestra")

Return 1
end function

on w_opc_nue_recurso1.create
int iCurrent
call super::create
this.cb_buscar=create cb_buscar
this.dw_consulta=create dw_consulta
this.cb_1=create cb_1
this.cb_aceptar=create cb_aceptar
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_buscar
this.Control[iCurrent+2]=this.dw_consulta
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_aceptar
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.gb_2
end on

on w_opc_nue_recurso1.destroy
call super::destroy
destroy(this.cb_buscar)
destroy(this.dw_consulta)
destroy(this.cb_1)
destroy(this.cb_aceptar)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;

dw_1.SetTransObject(n_cst_application.itr_appl)
dw_consulta.SetTransObject(n_cst_application.itr_appl)

dw_1.GetChild("talla",idc_talla)
idc_talla.SetTransObject(n_cst_application.itr_appl)

idc_talla.InsertRow(0)

dw_1.InsertRow(0)

is_select = dw_consulta.Describe("DataWindow.Table.Select")

is_where=Message.StringParm

If IsNull(is_where) then 
	is_where=""
ELSE
	is_where = " and (dt_muestras.co_talla = dt_med_mue.co_talla ) and ("+is_where
END IF

If len(is_where)>0 Then
	of_recuperar(is_where)
End If

If n_cst_application.il_fabMue<>0 then
	dw_1.SetItem(1,"fabrica",n_cst_application.il_fabMue)
	dw_1.SetItem(1,"linea",n_cst_application.il_lineaMue)
	dw_1.SetItem(1,"muestra",n_cst_application.il_muestra)
End If

end event

type cb_buscar from commandbutton within w_opc_nue_recurso1
integer x = 430
integer y = 924
integer width = 343
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Buscar"
end type

event clicked;If dw_1.AcceptText()<>1 Then
	MessageBox("Advertencia!","Datos no v$$HEX1$$e100$$ENDHEX$$lidos.",StopSign!)
	Return
End If

//   dt_muestras.co_talla = dt_med_mue.co_talla )       

is_where=" and (dt_muestras.co_talla = dt_med_mue.co_talla ) and ("
String ls_cad

ls_cad=String(dw_1.GetItemNumber(1,"fabrica"))

If Not IsNull(ls_cad) Then
	is_where+="m_muestras.co_fabrica="+ls_cad+" and "
End If

ls_cad=String(dw_1.GetItemNumber(1,"linea"))

If Not IsNull(ls_cad) Then
	is_where+="m_muestras.co_linea="+ls_cad+" and "
End If

ls_cad=String(dw_1.GetItemNumber(1,"muestra"))

If Not IsNull(ls_cad) Then
	is_where+="m_muestras.co_muestra="+ls_cad+" and "
End If

ls_cad=String(dw_1.GetItemNumber(1,"co_diseno"))

If Not IsNull(ls_cad) Then
	is_where+="dt_medidas_est.co_diseno="+ls_cad+" and "
End If  


ls_cad=dw_1.GetItemString(1,"descripcion")

If Not IsNull(ls_cad) Then
	is_where+="m_muestras.de_muestra like ~~'%"+ls_cad+"%~~' and "
End If        

ls_cad=dw_1.GetItemString(1,"talla")

If Not IsNull(ls_cad) Then
	is_where+="dt_muestras.co_talla="+ls_cad+" and "
End If   

ls_cad=String(dw_1.GetItemNumber(1,"recurso"))

If Not IsNull(ls_cad) Then
	is_where+="dt_medidas_est.co_recurso="+ls_cad+" and "
End If   


If Right(is_where,4)="and " Then
	is_where=left(is_where, len(is_where) - 4)+")"
	
End If

//dw_consulta.setsqlselect( is_select)
of_recuperar(is_where)




















end event

type dw_consulta from u_dw_application within w_opc_nue_recurso1
integer x = 965
integer y = 96
integer width = 2542
integer height = 964
integer taborder = 30
string dataobject = "d_muestra_diseno1"
boolean hscrollbar = true
end type

event clicked;call super::clicked;If Row=0 Then Return

of_filaSel(Row)


end event

event getfocus;//////////////////////////////////////////////////////////////////////////
// JUAN FERNANDO VASQUEZ DUQE 
// Jueves 24 de Octubre de 2002 HORA 08:50:59:781
// 
// OverWrite
//////////////////////////////////////////////////////////////////////////

end event

event doubleclicked;call super::doubleclicked;//////////////////////////////////////////////////////////////////////////
// JUAN FERNANDO VASQUEZ DUQE 
// Martes 17 de Diciembre de 2002 HORA 09:34:24:250
// 
// Para que con doble click sea igual a aceptar
//////////////////////////////////////////////////////////////////////////


If Row=0 Then Return

of_filaSel(Row)

cb_aceptar.Trigger Event Clicked()
end event

event itemchanged;call super::itemchanged;//////////////////////////////////////////////////////////////////////////
// JUAN FERNANDO VASQUEZ DUQE 
// Martes 07 de Enero de 2003 HORA 09:53:06:687
// 
// No se dejan modificar los datos
//////////////////////////////////////////////////////////////////////////
Return 2
end event

event itemfocuschanged;call super::itemfocuschanged;If Row=0 Then Return

of_filaSel(Row)


end event

type cb_1 from commandbutton within w_opc_nue_recurso1
integer x = 1733
integer y = 1144
integer width = 343
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_aceptar from commandbutton within w_opc_nue_recurso1
integer x = 1381
integer y = 1144
integer width = 343
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Aceptar"
end type

event clicked;If of_retorno()<>1 Then
	Return 
End If

CloseWithReturn(Parent,iou_param)
end event

type dw_1 from u_dw_application within w_opc_nue_recurso1
integer x = 50
integer y = 92
integer width = 850
integer height = 816
string dataobject = "d_ext_muestra_recurso"
boolean vscrollbar = false
end type

event getfocus;//////////////////////////////////////////////////////////////////////////
// JUAN FERNANDO VASQUEZ DUQE 
// Lunes 21 de Octubre de 2002 HORA 17:07:49:062
// 
// OverWrite!!
//////////////////////////////////////////////////////////////////////////

end event

type gb_1 from groupbox within w_opc_nue_recurso1
integer x = 41
integer y = 24
integer width = 878
integer height = 1072
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Muestra"
end type

type gb_2 from u_gb_base within w_opc_nue_recurso1
integer x = 942
integer y = 24
integer width = 2597
integer height = 1072
integer taborder = 0
string text = "Busqueda"
end type

