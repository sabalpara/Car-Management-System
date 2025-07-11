package backand;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.*;
@WebServlet("/regform")

public class register extends jakarta.servlet.http.HttpServlet {
	public static  void insert(String Email_id,String first_name,String last_name,String apt_name,String area_name, int apt_number,String password,int pin_code,Connection con,HttpServletRequest request,HttpServletResponse resp,String city,String state,long mobile) throws IOException, ServletException {
		PrintWriter out= resp.getWriter();
		try {
			 
			 String sql = String.format("insert into customer " +
					    "(\"Email_id\",first_name, last_name, area_name, pincode,apt_name,password) " +
					    "VALUES ('%s', '%s', '%s', '%s', %d, '%s', '%s');",
					    Email_id,  first_name, last_name, area_name,  pin_code,apt_name,password);
			 String sql2 = String.format("insert into address (pincode,city,state) VALUES (%d, '%s', '%s');", pin_code, city, state);
			 String sql3 = String.format("insert into phone_no (email_id,mobile_no) VALUES ( '%s', %d);", Email_id, mobile);


			 PreparedStatement ps2 = con.prepareStatement("select pincode from address ");
			 ResultSet rs=ps2.executeQuery();
			 int flag=0;
			
			
				// out.print("hi");
			 while(rs.next()) {
				/// out.print(rs.getString("pincode"));
				 if(rs.getString("pincode").equals(pin_code+"")) {
					 flag=1;
					//out.print("hi");
					 break;
					 
				 }
			 }
			 
			 if(flag==0) {
				// out.print("hi");
			 Statement  ps3 = con.createStatement();
			 int rowsInserted2 = ps3.executeUpdate(sql2);
			// out.print(rowsInserted2);
			 }
			 
			 /*else {
				 
				 Statement  ps3 = con.createStatement();
				 int rowsInserted2 = ps3.executeUpdate(sql2);
				 //out.print(rowsInserted2);
			 }*/
			 Statement  ps = con.createStatement();
			 int rowsInserted = ps.executeUpdate(sql);
			 int r2=ps.executeUpdate(sql3);
			  if (rowsInserted > 0) {
				  resp.setContentType("text/html");
				  //out.print("<h3 style='color:green'> user registered succesfully </h3>");
             RequestDispatcher rd=request.getRequestDispatcher("/index.jsp");
             rd.include(request, resp);
         } else {
        	 resp.setContentType("text/html");
			  //out.print("<h3 style='color:red'> user  not registered succesfully </h3>");
        RequestDispatcher rd=request.getRequestDispatcher("/register.jsp");
        rd.include(request, resp);
         }


		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
			resp.setContentType("text/html");
			  out.print("<h3 style='color:red'> "+e.getMessage() +"</h3>");
       RequestDispatcher rd=request.getRequestDispatcher("/register.jsp");
       rd.include(request, resp);
		}
	}
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 PrintWriter out= response.getWriter();	
		 String customer_id = request.getParameter("customer_id");
	        String first_name = request.getParameter("first_name");
	       
	        String last_name = request.getParameter("last_name");
	        String apt_name1 = request.getParameter("apt_name");
	        String area_name = request.getParameter("area_name");
	        String apt_number1 =request.getParameter("apt_number");
	        String password1 = request.getParameter("password");
	        String pin_code1 = request.getParameter("pin_code");
	        String city = request.getParameter("city");
	        String state = request.getParameter("state");
	        String mobile = request.getParameter("Mobile_number");
	        
	        
	        
	        try {
	        	
	            Class.forName("org.postgresql.Driver");

	            String url = "jdbc:postgresql://localhost:5432/postgres";
	            String username = "postgres";
	            String password2 = "jay";
	            
	            Connection con = DriverManager.getConnection(url, username, password2);

	           
	            Statement  ps = con.createStatement();

              
	            // Repeat similar checks for other fields

	          
	            	
	            	int apt_number = 0;
					int password = 0;
					int pin_code = 0;
					long mob1=0;
					if(password1.length()!=0 && apt_name1.length()!=0 && apt_number1.length()!=0 && pin_code1.length()!=0) {
	            		 
	            		 password=Integer.parseInt(password1);
	            		apt_number=Integer.parseInt(apt_number1);
	            		 pin_code=Integer.parseInt(pin_code1);
	            		 mob1=Long.parseLong(mobile);
	            	}
					
					insert(customer_id,first_name,last_name,apt_name1,area_name,apt_number,password1,pin_code,con,request, response,city,state,mob1);
	                
	            
	            
	           
	            con.close();
	        } 
	        catch (ClassNotFoundException e) {
	            e.printStackTrace();
	            System.out.println("PostgreSQL JDBC driver not found");
	        } catch (SQLException e) {
	            e.printStackTrace();
	            System.out.println("Connection to the database failed");
	        }
	 }
}
