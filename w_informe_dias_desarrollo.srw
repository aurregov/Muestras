HA$PBExportHeader$w_informe_dias_desarrollo.srw
forward
global type w_informe_dias_desarrollo from w_sheet
end type
type gb_2 from groupbox within w_informe_dias_desarrollo
end type
type cb_1 from commandbutton within w_informe_dias_desarrollo
end type
type dw_1 from u_dw_application within w_informe_dias_desarrollo
end type
type gb_1 from groupbox within w_informe_dias_desarrollo
end type
type dw_fechas from u_dw_application within w_informe_dias_desarrollo
end type
type dw_datos from u_dw_application within w_informe_dias_desarrollo
end type
end forward

global type w_informe_dias_desarrollo from w_sheet
integer width = 3045
integer height = 1628
string title = "Informe de d$$HEX1$$ed00$$ENDHEX$$as de desarrollo"
gb_2 gb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
dw_fechas dw_fechas
dw_datos dw_datos
end type
global w_informe_dias_desarrollo w_informe_dias_desarrollo

type prototypes
Public Function Long ShellExecute (Long hWnd, String lpOperation, String lpFile, String lpParameters, String lpDirectory, Long nShowCmd) Library "shell32.dll" Alias For "ShellExecuteA;Ansi"



end prototypes

type variables
integer ii_FileNum
Constant Long SW_SHOWNORMAL = 1

String is_where, is_filtro
end variables

forward prototypes
public function integer of_generarhtml ()
public function integer of_add (string a_texto)
end prototypes

public function integer of_generarhtml ();//////////////////////////////////////////////////////////////////////////
// JUAN FERNANDO VASQUEZ DUQUE 
// Jueves 03 de Marzo de 2005 HORA 17:16:09:406
// 
// Genera el informe de los grupos
//////////////////////////////////////////////////////////////////////////
DateTime ldt_fecha
String ls_fileName

String ls_directorio

n_cst_file_application lo_1

//ls_directorio=GetCurrentDirectory()
ls_directorio=lo_1.of_gettempdirectory()

//n_cst_application.Of_GetProFile(n_cst_application.is_pathfileconf,&
//					n_cst_application.is_sessionapp,"HTMLFOLDER")
If ls_directorio="" or IsNull(ls_directorio) Then
	MessageBox("Advertencia!","No se pudo crear el archivo.",StopSign!)
	Return -1
	//ls_directorio=GetCurrentDirectory()		
End If

ls_fileName=ls_directorio+"dias_desarrollo.html"

FileDelete (ls_fileName)

//If Not FileDelete (ls_fileName) Then
//	Return -1
//End If

//
ii_FileNum = FileOpen(ls_fileName, &
        LineMode!, Write!, LockWrite!, Append!)


of_add("<HTML><HEAD>")

of_add("<STYLE type=text/css>table.mtable td {border-bottom:2px solid #C1CDD8 ; border-right:1px solid #C1CDD8}.tdetest {background-color: #cff8fc; color: #000000; font-family: Verdana, Arial, sans-serif; font-size: 10px; font-weight: normal; } .tdetestb {background-color: #ffffff; color: #000000; font-family: Verdana, Arial, sans-serif; font-size: 10px; font-weight: normal; } .cellblue { background-color: #6651b0; color: #ffffff; font-family: Verdana, Arial, sans-serif; font-size: 11px; font-weight: bold; } </STYLE>")

of_add("</HEAD>")

of_add("<BODY bgColor=#ffffff leftMargin=0 topMargin=0 marginheight=~"0~" ")

of_add("marginwidth=~"0~">")
//////////////////////////////////////////////////////////////////////////
// Tabla de encabezado, muestra la cantidad de ordenes, la fecha
// y el filtro utilizado
//////////////////////////////////////////////////////////////////////////


String ls_usuario,ls_instancia

If Not n_cst_application.of_SelectServer(n_cst_application.itr_appl,&
												 ldt_fecha,ls_usuario,ls_instancia) Then
	Return -1
End If

of_add("<TABLE class=mtable cellSpacing=0 cellPadding=0 width=~"50%~" border=0>")

of_add("<TBODY>")

of_add("<TR class=cellblue>")

of_add("<TD>CRITERIO</TD>")

of_add("<TD>USUARIO</TD>")

of_add("<TD>FECHA</TD>")

of_add("<TD>CANTIDAD DE ORDENES</TD>")

of_add("</tr>")

of_add("<TR class=tdetest>")

of_add("<TD>")
of_add(is_filtro)
of_add("</TD>")

of_add("<TD>")
of_add(ls_usuario)
of_add("</TD>")

of_add("<TD>")
of_add(String(ldt_fecha))
of_add("</TD>")

of_add("<TD>")
of_add(String(dw_datos.RowCount()))
of_add("</TD>")

of_add("</TR>")


of_add("</TABLE>")	

of_add("<BR>")
of_add("<BR>")




of_add("<TABLE class=mtable cellSpacing=0 cellPadding=0 width=~"100%~" border=0>")

of_add("<TBODY>")

of_add("<TR class=cellblue>")

of_add("<TD>FABRICA</TD>")

of_add("<TD>LINEA</TD>")

of_add("<TD>MUESTRA</TD>")

of_add("<TD>REFERENCIA</TD>")

of_add("<TD>ORDEN</TD>")

of_add("<TD>TALLA</TD>")

of_add("<TD>CLIENTE</TD>")

of_add("<TD>DESARROLLADOR</TD>")

of_add("<TD>EJECUTIVA</TD>")

of_add("<TD>FECHA TEORICA INICIAL</TD>")

of_add("<TD>FECHA TEORICA FINAL</TD>")

of_add("<TD>DIAS TEORICOS</TD>")

of_add("<TD>FECHA INICIO REAL</TD>")

of_add("<TD>FECHA FIN REAL</TD>")

of_add("<TD>DIAS REAL</TD>")

of_add("<TD>DIAS ENTRE FIN TEORICO Y FIN REAL</TD>")

of_add("<TD>TOTAL COLORES</TD>")

of_add("<TD>PARES</TD>")

of_add("<TD>TEJIDO</TD>")

of_add("<TD>RECURSO</TD>")

of_add("<TD>CARACTERISTICA</TD>")

of_add("<TD>TIPO MUESTRA</TD>")

of_add("</tr>")

long i,ll_can,ll_grupo,ll_dato,j,ll_tot
String ls_dato

ll_tot=dw_datos.RowCount()

For i=1 To ll_tot
	
	If mod(i,2)=0 Then
		of_add("<TR class=tdetest>")
	Else
		of_add("<TR class=tdetestb>")
	End If	

	of_add("<TD>")
	ll_dato=dw_datos.GetItemNumber(i,"co_fabrica")
	of_add(String(ll_dato))
	of_add("</TD>")

	of_add("<TD>")
	ll_dato=dw_datos.GetItemNumber(i,"co_linea")
	of_add(String(ll_dato))
	of_add("</TD>")
	
	of_add("<TD>")
	ll_dato=dw_datos.GetItemNumber(i,"co_muestra")
	of_add(String(ll_dato))
	of_add("</TD>")	

   of_add("<TD>")
	ll_dato=dw_datos.GetItemNumber(i,"co_referencia")
	of_add(String(ll_dato))
	of_add("</TD>")
	
	of_add("<TD>")
	ll_dato=dw_datos.GetItemNumber(i,"nu_orden")
	of_add(String(ll_dato))
	of_add("</TD>")	
	
	of_add("<TD>")
	ls_dato=dw_datos.GetItemString(i,"de_talla")
	of_add(Trim(ls_dato))
	of_add("</TD>")
	

//	of_add("<TD>")
//	ll_dato=dw_datos.GetItemNumber(i,"cantidad_colores")
//	of_add(String(ll_dato))
//	of_add("</TD>")
//
	of_add("<TD>")
	ls_dato=dw_datos.GetItemString(i,"de_cliente")
	of_add(Trim(ls_dato))
	of_add("</TD>")
	
	of_add("<TD>")
	ls_dato=dw_datos.GetItemString(i,"de_desarrollador")
	of_add(Trim(ls_dato))
	of_add("</TD>")
	
	of_add("<TD>")
	ls_dato=dw_datos.GetItemString(i,"de_ejecutiva")
	of_add(Trim(ls_dato))
	of_add("</TD>")
	
//	of_add("<TD>")
//	ls_dato=dw_datos.GetItemString(i,"centro_proceso")
//	of_add(Trim(ls_dato))
//	of_add("</TD>")
//	
//	of_add("<TD>")
//	ls_dato=dw_datos.GetItemString(i,"grupo_proceso")
//	of_add(Trim(ls_dato))
//	of_add("</TD>")
//	
	of_add("<TD>")
	ldt_fecha=dw_datos.GetItemDatetime(i,"fecha_inicio_actual")
	of_add(String(ldt_fecha))
	of_add("</TD>")
	
	of_add("<TD>")
	ldt_fecha=dw_datos.GetItemDatetime(i,"fecha_fin_actual")
	of_add(String(ldt_fecha))
	of_add("</TD>")

	of_add("<TD>")
	ll_dato=dw_datos.GetItemNumber(i,"dias_teoricos")
	of_add(String(ll_dato))
	of_add("</TD>")	

	
	of_add("<TD>")
	ldt_fecha=dw_datos.GetItemDatetime(i,"fe_ini_real")
	of_add(String(ldt_fecha))
	of_add("</TD>")
	
	of_add("<TD>")
	ldt_fecha=dw_datos.GetItemDatetime(i,"fe_fin_real")
	of_add(String(ldt_fecha))
	of_add("</TD>")

	of_add("<TD>")
	ll_dato=dw_datos.GetItemNumber(i,"dias_reales")
	of_add(String(ll_dato))
	of_add("</TD>")	
	
	of_add("<TD>")
	ll_dato=dw_datos.GetItemNumber(i,"retraso")
	of_add(String(ll_dato))
	of_add("</TD>")	

	of_add("<TD>")
	ll_dato=dw_datos.GetItemNumber(i,"tot_colores")
	of_add(String(ll_dato))
	of_add("</TD>")	

	of_add("<TD>")
	ll_dato=dw_datos.GetItemNumber(i,"pares")
	of_add(String(ll_dato))
	of_add("</TD>")	

	of_add("<TD>")
	ls_dato=dw_datos.GetItemString(i,"de_tejido")
	of_add(Trim(ls_dato))
	of_add("</TD>")

   of_add("<TD>")
	ls_dato=dw_datos.GetItemString(i,"nom_recurso")
	of_add(Trim(ls_dato))
	of_add("</TD>")
	

	of_add("<TD>")
	ls_dato=dw_datos.GetItemString(i,"caracteristica")
	of_add(Trim(ls_dato))
	of_add("</TD>")

	of_add("<TD>")
	ls_dato=Trim(dw_datos.GetItemString(i,"tipo"))
	choose case ls_dato
		case 'N'
			ls_dato="NUEVA"
		case 'R'
			ls_dato="REFORMA"
		case 'C'
			ls_dato="MUESTRA PRODUCC"
	end choose
	of_add(ls_dato)
	of_add("</TD>")

	of_add("</TR>")
Next

of_add("</TABLE>")	
of_add("</BODY></HTML>")
FileClose(ii_FileNum)

ShellExecute (0, "", ls_fileName, "", "", SW_SHOWNORMAL)

Return 1
end function

public function integer of_add (string a_texto);If IsNull(a_texto) Then
	a_texto="$$HEX1$$a000$$ENDHEX$$"
End If
 
FileWrite(ii_FileNum, a_texto)

Return 1


end function

on w_informe_dias_desarrollo.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.dw_fechas=create dw_fechas
this.dw_datos=create dw_datos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_fechas
this.Control[iCurrent+6]=this.dw_datos
end on

on w_informe_dias_desarrollo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.dw_fechas)
destroy(this.dw_datos)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////////
// JUAN FERNANDO VASQUEZ DUQUE 
// Jueves 03 de Marzo de 2005 HORA 17:41:33:953
// 
// 
//////////////////////////////////////////////////////////////////////////

dw_1.InsertRow(0)
dw_fechas.InsertRow(0)

datawindowchild ldwc_tipoprod
n_cst_comun lo_comun
dw_1.GetChild("co_tipoprod", ldwc_tipoprod)

lo_comun.of_loadDddw(ldwc_tipoprod, n_cst_application.is_user, n_cst_application.itr_appl)

end event

type gb_2 from groupbox within w_informe_dias_desarrollo
integer x = 78
integer y = 948
integer width = 1495
integer height = 284
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha de finalizaci$$HEX1$$f300$$ENDHEX$$n de la orden"
end type

type cb_1 from commandbutton within w_informe_dias_desarrollo
integer x = 1678
integer y = 1068
integer width = 343
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar"
end type

event clicked;If dw_1.AcceptText()<>1 Then
	MessageBox("Advertencia!","Criterios no v$$HEX1$$e100$$ENDHEX$$lidos.",StopSign!)
	Return
End If

If dw_fechas.AcceptText()<>1 Then
	MessageBox("Advertencia!","Fechas no v$$HEX1$$e100$$ENDHEX$$lidas.",StopSign!)
	Return
End If

Datetime ldt_ini,ldt_fin
long     ll_tipoprod

ldt_ini=dw_fechas.GetItemDateTime(1,"fe_ini")
ldt_fin=dw_fechas.GetItemDateTime(1,"fe_fin")

ldt_ini=Datetime(Date(ldt_ini),Time(00:00:00))
ldt_fin=Datetime(Date(ldt_fin),Time(23:59:59))

//ll_tipoprod=dw_1.GetItemNumber(1,co_tipoprod)



String ls_cad_campo

is_where=''
is_filtro=''


ls_cad_campo=String(ldt_ini,"yyyy-mm-dd 00:00:00")
If Not IsNull(ls_cad_campo) AND ls_cad_campo<>'' Then
	is_where+=" AND (dt_mu_ord.fe_pr_apro >= DATETIME ("+ls_cad_campo+") YEAR TO SECOND)"
	is_filtro+="Fec.Inicial="+String(ldt_ini,"yyyy/mm/dd , ")
End If

//Field:fe_final
ls_cad_campo=String(ldt_fin,"yyyy-mm-dd 23:59:59")
//Messagebox('Var','ls_cad_campo='+ls_cad_campo+'~n')
If Not IsNull(ls_cad_campo) AND ls_cad_campo<>'' Then
	is_where+=" AND (dt_mu_ord.fe_pr_apro <= DATETIME ("+ls_cad_campo+") YEAR TO SECOND)"	
	is_filtro+="Fec.Final<="+String(ldt_fin,"yyyy/mm/dd , ")
End If

//Field:tipo_muestra
ls_cad_campo=dw_1.GetItemString(1,"tipo_muestra")
If Not IsNull(ls_cad_campo) Then
	is_where+=" AND (m_muestras.tipo_muestra=~~'"+ls_cad_campo+"~~')"
	is_filtro+="Tipo muestra= "+ls_cad_campo+", "
End If

//Field:co_tipoprod
ls_cad_campo=String(dw_1.GetItemNumber(1,"co_tipoprod"))
If Not IsNull(ls_cad_campo) Then
	is_where+=" AND (m_muestras.co_tipoprod="+ls_cad_campo+")"
	is_filtro+="Tipoprod = "+ls_cad_campo+", "
End If


//Field:co_cliente
ls_cad_campo=String(dw_1.GetItemNumber(1,"co_cliente"))
If Not IsNull(ls_cad_campo) Then
	is_where+=" AND (m_muestras.co_cliente="+ls_cad_campo+")"
	is_filtro+="Cliente = "+dw_1.GetItemString(1,"de_cliente")+", "
End If

//Field:co_sucursal
ls_cad_campo=String(dw_1.GetItemNumber(1,"co_sucursal"))
If Not IsNull(ls_cad_campo) Then
	is_where+=" AND (m_muestras.co_sucursal="+ls_cad_campo+")"
	is_filtro+="Sucursal = "+ls_cad_campo+", "
End If

//Field:desarrollador
ls_cad_campo=dw_1.GetItemString(1,"desarrollador")
If Not IsNull(ls_cad_campo) Then
		is_where+=" AND (dt_mu_ord.co_ctecnico = ~~'"+ls_cad_campo+"~~')"
		is_filtro+="Desarrollador = "+dw_1.GetItemString(1,"de_desarrollador")+", "
End If

//Field:co_ejecutiva
ls_cad_campo=String(dw_1.GetItemNumber(1,"co_ejecutiva"))
If Not IsNull(ls_cad_campo) Then
	is_where+=" AND (dt_mu_ord.co_ejecutiva="+ls_cad_campo+")"
	is_filtro+="Ejecutiva = "+dw_1.GetItemString(1,"de_ejecutiva")+", "
End If

////Field:condicion
//ls_cad_campo=String(dw_1.GetItemNumber(1,"condicion"))
//If Not IsNull(ls_cad_campo) Then
//	is_where+=" AND (dt_mu_ord.condicion="+ls_cad_campo+")"
//	Choose Case ls_cad_campo
//		Case '2'
//			is_filtro+="Condici$$HEX1$$f300$$ENDHEX$$n = PROGR., "
//		Case '3'
//			is_filtro+="Condici$$HEX1$$f300$$ENDHEX$$n = PROC. PROD., "
//	End Choose
//Else
//	is_where+=" AND (dt_mu_ord.condicion IN (2,3))"
//	is_filtro+="Condici$$HEX1$$f300$$ENDHEX$$n = PROGR. Y PROC. PROD., "
//End If

//Field:cilindros
ls_cad_campo=String(dw_1.GetItemNumber(1,"cilindros"))
If Not IsNull(ls_cad_campo) Then
	is_where+=" AND (m_recursos_tj.ca_cilindro="+ls_cad_campo+")"
	is_filtro+="Cilindros = "+ls_cad_campo+", "
Else
	is_where+=" AND (m_recursos_tj.ca_cilindro IN (1,2))"
	is_filtro+="Cilindros = 1 y 2, "
End If
// co fabrica

ls_cad_campo=String(dw_1.GetItemNumber(1,"co_fabrica"))
If Not IsNull(ls_cad_campo) Then
	is_where+=" AND (m_muestras.co_fabrica="+ls_cad_campo+")"
	is_filtro+="fabrica = "+ls_cad_campo+", "
End If

ls_cad_campo=String(dw_1.GetItemNumber(1,"co_linea"))
If Not IsNull(ls_cad_campo) Then
	is_where+=" AND (m_muestras.co_linea="+ls_cad_campo+")"
	is_filtro+="l$$HEX1$$ed00$$ENDHEX$$nea = "+ls_cad_campo+", "
End If

ls_cad_campo=String(dw_1.GetItemNumber(1,"co_muestra"))
If Not IsNull(ls_cad_campo) Then
	is_where+=" AND (m_muestras.co_muestra="+ls_cad_campo+")"
	is_filtro+="Muestra = "+ls_cad_campo+", "
End If

ls_cad_campo=String(dw_1.GetItemNumber(1,"nu_orden"))
If Not IsNull(ls_cad_campo) Then
	is_where+=" AND (dt_mu_ord.nu_orden="+ls_cad_campo+")"
	is_filtro+="Orden = "+ls_cad_campo+", "
End If


//-------------------------------------------------
If Right(is_filtro,2)=", " Then
	is_filtro=left(is_filtro,len(is_filtro) - 2)
End If
//-------------------------------------------------
//ls_cad_campo=dw_consulta.Describe("DataWindow.Table.Select")
//MessageBox('SELECT * FROM ~'dt_mu_ord~'','< '+is_where+'>~n Table.Select:'+ls_cad_campo,Exclamation!,OK!)
//*****************************************************************

String ls_sel_ini,ls_sel_mod
If is_where<>"" Then                      
	
	dw_datos.DataObject=dw_datos.DataObject
	dw_datos.SetTransObject(n_cst_application.itr_appl)
	ls_sel_ini = dw_datos.Describe("DataWindow.Table.Select")
	ls_sel_mod=ls_sel_ini+is_where
	//clipboard(ls_sel_mod)
	//Messagebox('Var','ls_sel_mod='+ls_sel_mod+'~n')
	ls_sel_mod = dw_datos.Modify("DataWindow.Table.Select = '" + ls_sel_mod + "'")
End If

dw_datos.SetTransObject(n_cst_application.itr_appl)

dw_datos.Retrieve()

of_generarhtml( )
end event

type dw_1 from u_dw_application within w_informe_dias_desarrollo
integer x = 78
integer y = 80
integer width = 2290
integer height = 848
string dataobject = "d_ext_criterios_ordenes_proceso"
boolean vscrollbar = false
boolean livescroll = false
end type

event doubleclicked;call super::doubleclicked;	String ls_tipo 
	n_cst_param lo_param
	n_cst_comun luo_comun



If dwo.name='desarrollador' Then
		OpenWithParm(w_bus_m_ctecnico,lo_param)
		lo_param=Message.PowerObjectParm
		If IsValid(lo_param) Then
			SetText(String(lo_param.is_vector[1]))
			AcceptText()
		End If
End If

If dwo.name='co_ejecutiva' Then
		ls_tipo=GetItemString(1,"tipo_muestra")
		If IsNull(ls_tipo) Then
			MessageBox("Advertencia!","Debe especificar el tipo de muestra.",StopSign!)
			Return
		End If
		lo_param.is_vector[1] = ls_tipo
		OpenWithParm(w_bus_ejecutivo_vendedor,lo_param)
		lo_param=Message.PowerObjectParm
		If IsValid(lo_param) Then
			SetText(String(lo_param.il_vector[1]))
			AcceptText()
		End If
End If

If dwo.name="id_grupo" then
	lo_param.il_vector[1]=1
	OpenWithParm(w_bus_grupo_act,lo_param)
	lo_param=Message.PowerObjectParm
	If IsValid(lo_param) Then
		SetText(String(lo_param.il_vector[1]))
		AcceptText()
		SetColumn('de_grupo')
		//SetItem(row,'de_grupo',lo_param.is_vector[1])		
	End If		
End If
end event

event itemchanged;call super::itemchanged;String ls_tipo_muestra
long ll_res
n_cst_comun_orden luo_comun

If dwo.name='co_ejecutiva' Then
	ls_tipo_muestra = This.GetItemString(1,'tipo_muestra')
	If IsNull(ls_tipo_muestra) Then
		MessageBox("Advertencia!","Especifique tipo de muestra.",StopSign!)
		Return 2
	End If

	If IsNull(Data) Then
		SetItem(1,"de_ejecutiva","")
		Return 0
	End If
	ll_res= luo_comun.of_nombreejecutiva(ls_tipo_muestra,Long(Data), &
													  n_cst_application.itr_appl)
													  
	If ll_res<>1 Then
		MessageBox('Advertencia',&
		'Ejecutiva no v$$HEX1$$e100$$ENDHEX$$lida.',StopSign!)
		Return 2
	End If
	
	This.SetItem(1,'de_ejecutiva',luo_comun.of_getstring(1))														  

End If	

If dwo.name='desarrollador' Then
	If IsNull(Data)Then 
		SetItem(1,"de_desarrollador",'')
		Return 0
	End If

	ll_res=luo_comun.of_nombredesarrollador(Lower(Data),n_cst_application.itr_appl)
	If ll_res<>1 then
		MessageBox("Advertencia!","C$$HEX1$$f300$$ENDHEX$$digo del Desarrollador no es v$$HEX1$$e100$$ENDHEX$$lido.",StopSign!)
		Return 2
	End If
	SetItem(1,"de_desarrollador",Trim(luo_comun.of_getString(1)))		
End If
long ll_grupo,ll_resultado
If dwo.name="id_grupo" Then
	ll_grupo=Long(Data)
	ll_resultado=luo_comun.of_nombregrupoact(ll_grupo,n_cst_application.itr_appl)
	If ll_resultado<>1 Then
		MessageBox("Advertencia!","Grupo de la operaci$$HEX1$$f300$$ENDHEX$$n no v$$HEX1$$e100$$ENDHEX$$lido.",StopSign!)
		Return 2
	End If
	SetItem(row,"de_grupo",luo_comun.of_getString(1))
End If

end event

type gb_1 from groupbox within w_informe_dias_desarrollo
integer x = 46
integer y = 12
integer width = 2789
integer height = 1252
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Especificar criterio"
end type

type dw_fechas from u_dw_application within w_informe_dias_desarrollo
integer x = 110
integer y = 1016
integer width = 1029
integer height = 184
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_ext_rango_datetime"
boolean vscrollbar = false
boolean livescroll = false
end type

type dw_datos from u_dw_application within w_informe_dias_desarrollo
boolean visible = false
integer x = 78
integer y = 1308
integer width = 608
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_inf_dias_desarrollo"
boolean vscrollbar = false
boolean livescroll = false
end type

event itemerror;call super::itemerror;/*-------------------------------------------------
	Develr.	: Carlos Andr$$HEX1$$e900$$ENDHEX$$s Rico
	Date		: Lunes 13 de Diciembre de 2004.H:11:40
---------------------------------------------------
---------------------------------------------------*/
Long ll_null
//-------------------------------------------------
If dwo.name = 'cantidad_colas' Then
	If Long(Data)=0 Then		
		SetNull(ll_null)
		This.SetItem(row,String(dwo.name),ll_null)
		Return 3
	End If
End If

If dwo.name='de_grupo' Then
		Return 1	
End If

end event

