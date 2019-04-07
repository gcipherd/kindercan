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

		int idEstanciaMax = 0;

		//Se saca el ultimo id que hay en la tabla "estancia" de la BD y se almacena el número en la variable idEstanciaMax
		try {
	            Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/kindercan","root","");
				//System.out.println("ConexiOn con la BD establecida");
				// Se crea una instancia del tipo declaraciOn
				Statement stmt = con.createStatement();
				stmt.executeQuery("use kindercan");//Se indica quÃ© base de datos que usarÃ¡
	            ResultSet rsEstancia = stmt.executeQuery("SELECT MAX(idEstancia) FROM estancia;");
	            if (rsEstancia.next()) {
	            	idEstanciaMax = rsEstancia.getInt(1);
	        	}
			}catch (SQLException e){
				out.println("Error al realizar la conexiOn con mysql");
			}catch (Exception e){
				out.println("Error:\n" + e.getMessage());
				e.printStackTrace();
			}

		//Se genera el nuevo id para la estancia que se está registrando
		int idEstanciaNuevo = idEstanciaMax + 1;
		//Se almacenan en variables los datos del perro ingresados en el formulario
		String tipoEstancia = request.getParameter("tipoEstancia");
		int perro = Integer.parseInt(request.getParameter("perro"));
		String inicio = request.getParameter("inicio");
		String salida = request.getParameter("salida");
		String tipoDia = request.getParameter("tipoDia");
		String interno = request.getParameter("interno");
		int adeudo = Integer.parseInt(request.getParameter("adeudo"));
		int cargosExtras = Integer.parseInt(request.getParameter("cargosExtras"));
		String pagado = request.getParameter("pagado");


		//Se realiza la insercion el la tabla "perro" de la BD
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/kindercan","root","");
			// Se crea una instancia del tipo declaraciOn
			Statement stmt = con.createStatement();
	        stmt.executeQuery("use kindercan");
	        int res = stmt.executeUpdate("INSERT INTO estancia VALUES(" + idEstanciaNuevo + ", '" + tipoEstancia.toUpperCase() + "', " + perro + ", '" + inicio + "', '" + salida + "', '" + tipoDia.toUpperCase() + "', '" + interno.toUpperCase() + "', " + adeudo + ", " + cargosExtras + ", '" + pagado.toUpperCase() + "')"); // idDuenoMax asigna temporalmente el id del dueño, para posteriormente actualizarse al momento de crear el dueño
			if (res == 1){
				out.println("Estancia registrada");
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


		response.sendRedirect("index.jsp");

%>