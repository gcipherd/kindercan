<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>

<%/*
	@author EquipoFortuna
	@version 1.1.0
	Grupo: 1592
	Proyecto final: Aplicación web para Kindercan
	Fecha de entrega: 08 de enero del 2019

*/%>

<%
	Calendar calendario = Calendar.getInstance(java.util.Locale.getDefault());
	Date fecha = calendario.getTime();
	DateFormat formatoHora = DateFormat.getTimeInstance(DateFormat.SHORT);
	DateFormat formatoFecha = DateFormat.getDateInstance(java.text.DateFormat.FULL);

	String fechaActual = formatoFecha.format(fecha).toUpperCase() + ", " + formatoHora.format(fecha);
%>

<%
	

%>

<!DOCTYPE html>
<html lang="es-MX">
<head>
	<meta charset="UTF-8">
	<title>Kinder Can</title>
	<link rel="shortcut icon" href="img/perroIcono.png">
	<link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
	<link type="text/css" rel="stylesheet" href="css/style.css">
</head>
<body>
	<nav class="navbar navbar-light bg-light sticky-top">
	  <a class="navbar-brand" href="index.jsp">
	    <img src="img/kindercanLogo.png" height="50" class="d-inline-block align-top" alt="Logo">
	  </a>
	  <h2>¡BIENVENIDO!</h2>
	  <p class="text-right font-weight-bold"><%out.println(fechaActual);%></p>
	</nav>

	<main>
		<!-- Inicia menú -->
		<div class="menuRegistrando border">
			<ul class="nav nav-pills flex-column">
			  <li class="nav-item">
			    <a class="nav-link sobre" href="index.jsp">Inicio</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link active" href="#">Registrar</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link sobre" href="consulta.jsp">Consultar mascota</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link sobre" href="actualizacion.jsp">Actualizar datos</a>
			  </li>
			</ul>
			<img class="huellas" src="img/huellas.gif" height="350" alt="Huella">
		</div>
		<!-- Termina menú -->

		<!-- Inicia selección -->
		<div id="seleccionarDueno"><br>
			<center><h1>Por favor, selecciona al dueño...</h1></center>
			<br>
			<!-- Se crea un formulario para mostrar una lista de dueños-->
			<div>
				<form class="formulario container" action="existeCliente.jsp" method="POST">
					<!-- Lista de dueños registrados en la BD -->
					<select name="dueno">
						<option disabled selected>Lista de dueños ordenada por APELLIDOS</option>
						<%
							try {
						            Class.forName("com.mysql.jdbc.Driver");
									Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/kindercan","root","");
									//System.out.println("ConexiOn con la BD establecida");
									// Se crea una instancia del tipo declaraciOn
									Statement stmt = con.createStatement();
									stmt.executeQuery("use kindercan");//Se indica quÃ© base de datos que usarÃ¡
						            ResultSet rs = stmt.executeQuery("SELECT * FROM dueno;");
						            //Se imprimen todos los clientes en forma de lista
						            while(rs.next()) {
										out.println("<option value='" + rs.getInt("idDueno") + "'><b>"+ rs.getString("apellidoPaterno") + "</b> " + rs.getString("apellidoMaterno") + " " + rs.getString("nombre") + " (id: " + rs.getInt("idDueno") + ")</option>");
									}
								}catch (SQLException e){
									out.println("Error al realizar la conexión con mysql");
								}catch (Exception e){
									out.println("Error:\n" + e.getMessage());
									e.printStackTrace();
								}
						%>
					</select>
					<br><br>
					<input id="registrar" class="btn btn-outline-success" type="submit" value="¡Asignar dueño!">
				</form>
			</div>
		</div>
		<!-- Termina selección -->

	</main>

	<footer>
		<div class="fixed-bottom pie">
			<p>© 2019 Kinder Can &nbsp|&nbsp Todos los derechos reservados.</p>
		</div>
	</footer>
	
</body>
<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
</html>