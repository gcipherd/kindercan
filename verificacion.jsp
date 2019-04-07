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

	String hayDueno = request.getParameter("duenoRegistrado");

	if (hayDueno.equals("si")) {

		int idPerroMax = 0;
		int idDuenoMax = 0;

		//Se saca el ultimo id que hay en la tabla "perro" y "dueno" de la BD y se almacena el número en la variable idPerroMax e idDuenoMax
		try {
	            Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/kindercan","root","");
				//System.out.println("ConexiOn con la BD establecida");
				// Se crea una instancia del tipo declaraciOn
				Statement stmt = con.createStatement();
				stmt.executeQuery("use kindercan");//Se indica quÃ© base de datos que usarÃ¡
	            ResultSet rsPerro = stmt.executeQuery("SELECT MAX(idPerro) FROM perro;");
	            if (rsPerro.next()) {
	            	idPerroMax = rsPerro.getInt(1);
	        	}
	        	ResultSet rsDueno = stmt.executeQuery("SELECT MAX(idDueno) FROM dueno;");
	        	if (rsDueno.next()) {
	            	idDuenoMax = rsDueno.getInt(1);
	        	}
			}catch (SQLException e){
				out.println("Error al realizar la conexiOn con mysql");
			}catch (Exception e){
				out.println("Error:\n" + e.getMessage());
				e.printStackTrace();
			}

		//Se genera el nuevo id para el perro y del dueño que se está registrando
		int idDuenoNuevo = idDuenoMax + 1;
		int idPerroNuevo = idPerroMax + 1;
		//Se almacenan en variables los datos del perro ingresados en el formulario
		String nombrePerro = request.getParameter("nombrePerro");
		String raza = request.getParameter("raza");
		String sexo = request.getParameter("sexo");
		String fechaNacimiento = request.getParameter("fechaNacimiento");
		String enfermedad = request.getParameter("enfermedad");
		String celo = request.getParameter("celo");
		String tratamiento = request.getParameter("tratamiento");
		String descripcion = request.getParameter("descripcion");

		//Se realiza la insercion el la tabla "perro" de la BD
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/kindercan","root","");
			// Se crea una instancia del tipo declaraciOn
			Statement stmt = con.createStatement();
	        stmt.executeQuery("use kindercan");
	        int res = stmt.executeUpdate("INSERT INTO perro VALUES(" + idPerroNuevo + ", '" + nombrePerro.toUpperCase() + "', '" + raza.toUpperCase() + "', '" + sexo + "', '" + fechaNacimiento + "', '" + enfermedad + "', '" + celo + "', '" + tratamiento + "', '" + descripcion + "', " + idDuenoMax + ")"); //se guarda en idDueno el numero máximo temporalmente, para después actualizarse con el id correcto.
			if (res == 1){
				out.println("Mascota registrada");
			} else {
				out.println("Registro no insertado");
			}
		}catch (SQLException e){
			out.println("Error al realizar la inserciOn en mysql");
			if (e != null){
				out.println("<br>SQLState: " + e.getSQLState());
				out.println("<br>Mensaje: " + e.getMessage());
				out.println("<br>COdigo: " + e.getErrorCode());
				e.getNextException();
				out.println(" -------------------------------------- ");
			}
		}catch (Exception e){
			out.println("Error:\n" + e.getMessage());
			e.printStackTrace();
		}

		response.sendRedirect("seleccionarDueno.jsp");

	} else if (hayDueno.equals("no")) {

		int idPerroMax = 0;
		int idDuenoMax = 0;

		//Se saca el ultimo id que hay en la tabla "perro" y "dueno" de la BD y se almacena el número en la variable idPerroMax e idDuenoMax
		try {
	            Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/kindercan","root","");
				//System.out.println("ConexiOn con la BD establecida");
				// Se crea una instancia del tipo declaraciOn
				Statement stmt = con.createStatement();
				stmt.executeQuery("use kindercan");//Se indica quÃ© base de datos que usarÃ¡
	            ResultSet rsPerro = stmt.executeQuery("SELECT MAX(idPerro) FROM perro;");
	            if (rsPerro.next()) {
	            	idPerroMax = rsPerro.getInt(1);
	        	}
	        	ResultSet rsDueno = stmt.executeQuery("SELECT MAX(idDueno) FROM dueno;");
	        	if (rsDueno.next()) {
	            	idDuenoMax = rsDueno.getInt(1);
	        	}
			}catch (SQLException e){
				out.println("Error al realizar la conexiOn con mysql");
			}catch (Exception e){
				out.println("Error:\n" + e.getMessage());
				e.printStackTrace();
			}

		//Se genera el nuevo id para el perro y del dueño que se está registrando
		int idDuenoNuevo = idDuenoMax + 1;
		int idPerroNuevo = idPerroMax + 1;
		//Se almacenan en variables los datos del perro ingresados en el formulario
		String nombrePerro = request.getParameter("nombrePerro");
		String raza = request.getParameter("raza");
		String sexo = request.getParameter("sexo");
		String fechaNacimiento = request.getParameter("fechaNacimiento");
		String enfermedad = request.getParameter("enfermedad");
		String celo = request.getParameter("celo");
		String tratamiento = request.getParameter("tratamiento");
		String descripcion = request.getParameter("descripcion");

		//Se realiza la insercion el la tabla "perro" de la BD
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/kindercan","root","");
			// Se crea una instancia del tipo declaraciOn
			Statement stmt = con.createStatement();
	        stmt.executeQuery("use kindercan");
	        int res = stmt.executeUpdate("INSERT INTO perro VALUES(" + idPerroNuevo + ", '" + nombrePerro.toUpperCase() + "', '" + raza.toUpperCase() + "', '" + sexo + "', '" + fechaNacimiento + "', '" + enfermedad + "', '" + celo + "', '" + tratamiento + "', '" + descripcion + "', " + idDuenoMax + ")"); // idDuenoMax asigna temporalmente el id del dueño, para posteriormente actualizarse al momento de crear el dueño
			if (res == 1){
				out.println("Mascota registrada");
			} else {
				out.println("Registro no insertado");
			}
		}catch (SQLException e){
			out.println("Error al realizar la inserciOn en mysql");
			if (e != null){
				out.println("<br>SQLState: " + e.getSQLState());
				out.println("<br>Mensaje: " + e.getMessage());
				out.println("<br>COdigo: " + e.getErrorCode());
				e.getNextException();
				out.println(" -------------------------------------- ");
			}
		}catch (Exception e){
			out.println("Error:\n" + e.getMessage());
			e.printStackTrace();
		}


		response.sendRedirect("registroDueno.jsp");

	}

%>