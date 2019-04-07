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

		int idDuenoMax = 0;
		int idPerroMax = 0;

		//Se saca el ultimo id que hay en la tabla  "dueno" de la BD y se almacena el número en la variable idDuenoMax
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
		int idPerro = idPerroMax + 1;
		//Se almacenan en variables los datos del dueño ingresados en el formulario
		String nombreDueno = request.getParameter("nombreDueno");
		String apellidoPaterno = request.getParameter("apellidoPaterno");
		String apellidoMaterno = request.getParameter("apellidoMaterno");
		String delegacion = request.getParameter("delegacion");
		String colonia = request.getParameter("colonia");
		String codigoPostal = request.getParameter("codigoPostal");
		String calle = request.getParameter("calle");
		String numeroExterior = request.getParameter("numeroExterior");
		String numeroInterior = request.getParameter("numeroInterior");
		String telefono = request.getParameter("telefono");

		//Se realiza la insercion el la tabla "dueno" de la BD
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/kindercan","root","");
			// Se crea una instancia del tipo declaraciOn
			Statement stmt = con.createStatement();
	        stmt.executeQuery("use kindercan");
	        int res = stmt.executeUpdate("INSERT INTO dueno VALUES(" + idDuenoNuevo + ", '" + nombreDueno.toUpperCase() + "', '" + apellidoPaterno.toUpperCase() + "', '" + apellidoMaterno.toUpperCase() + "', '" + delegacion.toUpperCase() + "', '" + colonia.toUpperCase() + "', '" + codigoPostal + "', '" + calle.toUpperCase() + "', '" + numeroExterior + "', '" + numeroInterior + "', '" + telefono + "')");
			if (res == 1){
				out.println("Mascota registrada");
				String mensaje = "<script type='text/javascript'>alert('¡Dueño registrado!');</script>"; 
				out.println(mensaje);

				response.sendRedirect("index.jsp");
			} else {
				out.println("Registro no insertado");
			}
			stmt.executeUpdate("UPDATE perro SET idDueno = " + idDuenoNuevo + " WHERE idPerro = " + idPerroMax); // Actualiza el Id del Dueño del perro
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



%>