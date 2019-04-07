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
			    <a class="nav-link sobre" href="registrando.jsp">Registrar</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link sobre" href="consulta.jsp">Consultar mascota</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link active" href="#">Actualizar datos</a>
			  </li>
			</ul>
			<img class="huellas" src="img/huellas.gif" height="350" alt="Huella">
		</div>
		<!-- Termina menú -->

				<!-- Inicia selección -->
		<div id="seleccionarPerro"><br>
			<center><h1>Datos de la mascota a editar</h1></center>
			<br>
				<%
					String perro = request.getParameter("perro");
					int idPerro = Integer.parseInt(perro);
					try {
					            Class.forName("com.mysql.jdbc.Driver");
								Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/kindercan","root","");
								//System.out.println("ConexiOn con la BD establecida");
								// Se crea una instancia del tipo declaraciOn
								Statement stmt = con.createStatement();
								stmt.executeQuery("use kindercan");//Se indica quÃ© base de datos que usarÃ¡
					            ResultSet rs = stmt.executeQuery("SELECT * FROM perro WHERE idPerro = " + idPerro + ";");
					            while(rs.next()) {
									out.println("Nombre: " + rs.getString("nombre") + "<br>");
									out.println("Raza: " + rs.getString("raza") + "<br>");
									out.println("Sexo: " + rs.getString("sexo") + "<br>");
									out.println("Fecha de Nacimiento: " + rs.getString("fechaNacimiento") + "<br>");
									out.println("Enfermedad: " + rs.getString("enfermedad") + "<br>");
									out.println("Celo: " + rs.getString("celo") + "<br>");
									out.println("Tratamiento: " + rs.getString("tratamiento") + "<br>");
									out.println("Descripcion: " + rs.getString("descripcion") + "<br>");
									out.println("ID Dueño: " + rs.getString("idDueno"));
								}
							}catch (SQLException e){
								System.out.println("Error al realizar la conexiOn con mysql");
							}catch (Exception e){
								System.out.println("Error:\n" + e.getMessage());
								e.printStackTrace();
							}
				%>

				<center><h1>Nuevos datos</h1></center>

	
		<!-- Inicia formulario -->
		<div><br>
			<form class="formulario container" action="actualizacionMascota.jsp" method="POST">
				<h2>Registro de la mascota</h2>
				<div class="form-row">
					<div class="col-auto">
						<label for="idPerro">ID Perro</label>
						<br>
						<% 

							out.println("<input type='text' name='idPerro' value='" + idPerro + "' required>");
						%>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="nombrePerro">Nombre de la mascota</label>
						<br>
					<input class="form-control seleccion form-control-sm" type="text" name="nombrePerro" required>
							
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="raza">Raza</label>
						<br>
						<input class="form-control seleccion form-control-sm" type="text" name="raza" required>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="sexo">Sexo</label>
						<br>
						<select name="sexo" class="form-control seleccion form-control-sm" required>
							<option disabled selected>Selecciona el sexo</option>
							<option value="H">HEMBRA</option>
							<option value="M">MACHO</option>
						</select>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="fechaNacimiento">Fecha de nacimineto</label>
						<br>
						<input class="form-control seleccion form-control-sm" type="date" name="fechaNacimiento" required>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="enfermedad">Enfermedad</label>
						<br>
						<input onClick="this.select();" class="form-control seleccion form-control-sm" type="text" name="enfermedad" value="NINGUNA" required>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="celo">En celo</label>
						<br>
						<select name="celo" class="form-control seleccion form-control-sm" required>
							<option selected value="NO TIENE">NO TIENE</option>
							<option value="SI">SÍ</option>
							<option value="NO">NO</option>
						</select>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="tratamiento">Tratamiento</label>
						<br>
						<input onClick="this.select();" class="form-control seleccion form-control-sm" type="text" name="tratamiento" value="NINGUNO" required>
					</div>
					<br><br>
					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="descripcion">Descripción</label>
						<br>
						<input onClick="this.select();" class="form-control seleccion form-control-sm" type="text" name="descripcion" value="NINGUNA" required>
					</div>

					<div class="col-lg-6 col-md-6 col-sm-12">
						<label for="idDueno">Dueño:</label>
						<br>
						<select name="idDueno" class="form-control seleccion form-control-sm" required>
							<option disabled selected>Selecciona el dueño</option>
							<%
							try {
						            Class.forName("com.mysql.jdbc.Driver");
									Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kindercan","root","");
									//System.out.println("ConexiOn con la BD establecida");
									// Se crea una instancia del tipo declaraciOn
									Statement stmnt = conn.createStatement();
									stmnt.executeQuery("use kindercan");//Se indica quÃ© base de datos que usarÃ¡
						            ResultSet rs = stmnt.executeQuery("SELECT * FROM dueno;");
						            //Se imprimen todos los clientes en forma de lista
						            while(rs.next()) {
										out.println("<option value='" + rs.getInt("idDueno") + "'><b>"+ rs.getString("nombre") + "</b> " + rs.getString("apellidoPaterno") + " " + rs.getString("apellidoMaterno") + " (id: " + rs.getInt("idDueno") + ")</option>");
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
					<br><br>
					<div class="col-12">
						<br>
						<input id="registrar" class="btn btn-outline-success" type="submit" value="¡Actualizar mascota!">
					</div>
				</div>
			</form>
		</div>
		<!-- Termina formulario -->

			<br>
			<div>
				
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