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
		String dueno = request.getParameter("dueno");
		int idDueno = Integer.parseInt(dueno);
		String nombreDueno = "";
		String apellidoPaterno = "";
		String apellidoMaterno = "";
		String delegacion = "";
		String colonia = "";
		String codigoPostal = "";
		String calle = "";
		String numeroExterior = "";
		String numeroInterior = "";
		String telefono = "";

		int idPerroMax = 0;

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

				stmt.executeUpdate("UPDATE perro SET idDueno = " + idDueno + " WHERE idPerro = " + idPerroMax);
				response.sendRedirect("index.jsp");

		}catch (SQLException e){
				out.println("Error al realizar la conexiOn con mysql");
		}catch (Exception e){
				out.println("Error:\n" + e.getMessage());
				e.printStackTrace();
		}		
%>