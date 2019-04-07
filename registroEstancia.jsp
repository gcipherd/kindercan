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

		<!-- Inicia formulario -->
		<div><br>
			<form class="formulario container" action="insertarEstancia.jsp" method="POST">
				<h2>Registro de estancia</h2>
				<div class="form-row">
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="tipoEstancia">Tipo de la estancia</label>
						<br>
						<select name="tipoEstancia" class="form-control seleccion form-control-sm" required>
							<option disabled selected>Selecciona el tipo</option>
							<option value="G">GUARDERIA</option>
							<option value="E">ENTRENAMIENTO</option>
						</select>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="perro">Mascota:</label>
						<br>
						<select name="perro" class="form-control seleccion form-control-sm" required>
							<option disabled selected>Selecciona la mascota</option>
							<%
							try {
						            Class.forName("com.mysql.jdbc.Driver");
									Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/kindercan","root","");
									//System.out.println("ConexiOn con la BD establecida");
									// Se crea una instancia del tipo declaraciOn
									Statement stmt = con.createStatement();
									stmt.executeQuery("use kindercan");//Se indica quÃ© base de datos que usarÃ¡
						            ResultSet rs = stmt.executeQuery("SELECT * FROM perro;");
						            //Se imprimen todos los clientes en forma de lista
						            while(rs.next()) {
										out.println("<option value='" + rs.getInt("idPerro") + "'><b>"+ rs.getString("nombre") + "</b> " + rs.getString("raza") + " " + rs.getString("sexo") + " (id: " + rs.getInt("idPerro") + ")</option>");
									}
								}catch (SQLException e){
									out.println("Error al realizar la conexión con mysql");
								}catch (Exception e){
									out.println("Error:\n" + e.getMessage());
									e.printStackTrace();
								}
						%>
						</select>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="inicio">Inicio</label>
						<br>
						<input class="form-control seleccion form-control-sm" type="date" name="inicio" required>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="salida">Salida</label>
						<br>
						<input class="form-control seleccion form-control-sm" type="date" name="salida" required>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="tipoDia">Duración de la estancia</label>
						<br>
						<select name="tipoDia" class="form-control seleccion form-control-sm" required>
							<option disabled selected>Selecciona la duración</option>
							<option value="C">DIA COMPLETO</option>
							<option value="M">MEDIO DIA</option>
							<option value="I">INTERMITENTE</option>
						</select>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="interno">Interno</label>
						<br>
						<select name="interno" class="form-control seleccion form-control-sm" required>
							<option disabled selected>Elija una opción</option>
							<option value="SI">SI</option>
							<option value="NO">NO</option>
						</select>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="adeudo">Adeudo</label>
						<br>
						<input onClick="this.select();" class="form-control seleccion form-control-sm" type="number" name="adeudo" required>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="cargosExtras">Cargos extras</label>
						<br>
						<input onClick="this.select();" class="form-control seleccion form-control-sm" type="number" name="cargosExtras" required>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="pagado">Pagado</label>
						<br>
						<select name="pagado" class="form-control seleccion form-control-sm" required>
							<option disabled selected>Elija una opción</option>
							<option value="SI">SI</option>
							<option value="NO">NO</option>
						</select>
					</div>
					<br><br>
					<div class="col-12">
						<br>
						<input id="registrar" class="btn btn-outline-success" type="submit" value="¡Registrar estancia!">
					</div>
				</div>
			</form>
		</div>
		<!-- Termina formulario -->
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