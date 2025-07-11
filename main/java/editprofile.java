package backand;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.*;
@WebServlet("/editprofile")

public class editprofile extends jakarta.servlet.http.HttpServlet {
	public static  void insert(String Email_id,String first_name,String last_name,String apt_name,String area_name,String password,int pin_code,Connection con,HttpServletRequest request,HttpServletResponse resp,String city,String state,long mobile) throws IOException, ServletException {
		PrintWriter out= resp.getWriter();
		HttpSession session=request.getSession();
		try {
			 
			 String sql = String.format("update customer " +
					    "set first_name='%s', last_name='%s', area_name='%s', pincode=%d, apt_name='%s', password='%s' where \"Email_id\"='%s';",
					    first_name, last_name, area_name,  pin_code,apt_name,password,Email_id);
			 String sql2 = String.format("insert into address (pincode,city,state) VALUES (%d, '%s', '%s');", pin_code, city, state);	
			 String sql3 = String.format("update phone_no set mobile_no=%d where email_id='%s'	;", mobile,Email_id);


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
				  out.print("<h3 style='color:green'>update successful, please re-login for update</h3>");
				 
	            /*	session.removeAttribute("first_name" );
	            	session.removeAttribute("last_name" );
	            	session.removeAttribute("mobile" );
	            	session.removeAttribute("name" );
	            	session.removeAttribute("pin_code");
	            	session.removeAttribute("area_name");
	            	session.removeAttribute("apt_name");
	            	session.removeAttribute("password");
	            	session.removeAttribute("city");
	            	
	            	session.setAttribute("first_name",request.getAttribute("first_name") );
	            	session.setAttribute("last_name",request.getAttribute("last_name") );
	            	
	            	session.setAttribute("name",request.getAttribute("first_name")+" "+request.getAttribute("last_name") );
	            	session.setAttribute("pin_code", request.getAttribute("pin_code"));
	            	session.setAttribute("area_name", request.getAttribute("area_name"));
	            	session.setAttribute("apt_name", request.getAttribute("apt_name"));
	            	session.setAttribute("password", request.getAttribute("password"));
	            	session.setAttribute("mobile", request.getAttribute("Mobile_number"));
	            	session.setAttribute("city", request.getAttribute("city"));*/
             RequestDispatcher rd=request.getRequestDispatcher("/index.jsp");
             rd.include(request, resp);
         } else {
        	 resp.setContentType("text/html");
			  out.print("<h3 style='color:red'>update unsuccessful</h3>");
        RequestDispatcher rd=request.getRequestDispatcher("/editprofile.jsp");
        rd.include(request, resp);
         }


		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
			resp.setContentType("text/html");
			  out.print("<h3 style='color:red'> "+e.getMessage() +"</h3>");
       RequestDispatcher rd=request.getRequestDispatcher("/homepage.jsp");
       rd.include(request, resp);
		}
	}
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 PrintWriter out= response.getWriter();	
		 HttpSession session=request.getSession();
		 	String customer_id = (String) session.getAttribute("email");
	        String first_name = request.getParameter("first_name");
	       
	        String last_name = request.getParameter("last_name");
	        String apt_name1 = request.getParameter("apt_name");
	        String area_name = request.getParameter("area_name");
	       // String apt_number1 =request.getParameter("apt_number");
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

	          
	            	
	            	//int apt_number = 0;
					int password = 0;
					int pin_code = 0;
					long mob1=0;
					if(password1.length()!=0 && apt_name1.length()!=0 && pin_code1.length()!=0) {
	            		 
	            		 password=Integer.parseInt(password1);
	            		//apt_number=Integer.parseInt(apt_number1);
	            		 pin_code=Integer.parseInt(pin_code1);
	            		 mob1=Long.parseLong(mobile);
	            	}
					
					insert(customer_id,first_name,last_name,apt_name1,area_name,password1,pin_code,con,request, response,city,state,mob1);
	                
	            
	            
	           
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
