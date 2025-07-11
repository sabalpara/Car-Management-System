package backand;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/loginform")
public class login extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out= response.getWriter();
		String email=request.getParameter("username");
		String password=request.getParameter("password");
		String role=request.getParameter("role");
		System.out.println(email);
		System.out.println(password);
		try {
        	//out.print("hello");
			response.setContentType("text/html");
            Class.forName("org.postgresql.Driver");

            String url = "jdbc:postgresql://localhost:5432/postgres";
            String username = "postgres";
            String password2 = "jay";
            
            Connection con = DriverManager.getConnection(url, username, password2);

           
            PreparedStatement ps = con.prepareStatement("select * from customer where \"Email_id\"=?");
            
            ps.setString(1, email);
            ResultSet rs=ps.executeQuery();
            ps=con.prepareStatement("select * from phone_no where email_id =?");
            ps.setString(1, email);
            ResultSet rs2=ps.executeQuery();
            HttpSession session=request.getSession();
            if(rs.next() && rs.getString("password").equals(password)) {
            	
            	session.setAttribute("email", email);
            	session.setAttribute("first_name",rs.getString("first_name") );
            	session.setAttribute("last_name",rs.getString("last_name") );
            	
            	session.setAttribute("name",rs.getString("first_name")+" "+rs.getString("last_name") );
            	session.setAttribute("pin_code", rs.getString("pincode"));
            	session.setAttribute("area_name", rs.getString("area_name"));
            	session.setAttribute("apt_name", rs.getString("apt_name"));
            	session.setAttribute("password", rs.getString("password"));
            	session.setAttribute("image", rs.getString("image"));
            	if(rs2.next())
            	{
            	session.setAttribute("mobile", rs2.getString("mobile_no"));
                    }
            	 ps = con.prepareStatement("select * from address where pincode=?");
                 ps.setInt(1, rs.getInt("pincode"));  // Assuming pincode is an integer
                 ResultSet rs3 = ps.executeQuery();
                 if(rs3.next())
             	{
            	session.setAttribute("city", rs3.getString("city"));
                session.setAttribute("state", rs3.getString("state"));
             	}
            	//System.out.println( rs.getString("image")+"jay");
      
            	//out.print("hi");
            	
            	PreparedStatement ps1 = con.prepareStatement("select 1 from admin where admin_id=?");
            	ps1.setString(1, email);
            	 rs3=ps1.executeQuery();
            	
            	PreparedStatement ps2 = con.prepareStatement("select 1 from mechanic where  mechanic_id=?");
            	ps2.setString(1, email);
            	ResultSet rs4=ps2.executeQuery();
            	 if ("mechanic".equals(role)) {
            		 if(rs4.next())
                 	{
                 		RequestDispatcher rd=request.getRequestDispatcher("/mprofile.jsp");
                    	 rd.include(request, response);
                 	}
            		 else {
                 		//out.print("<h2 style='color:red'> please register as a mechanic </h2>");
                 		response.setContentType("text/html");

                	    String messageHtml = """
                	        <div id="successMessage" style="display: none; position: fixed; top: 20px; right: 20px; 
                	             background-color: #10b981; color: white; padding: 1rem 2rem; border-radius: 0.5rem; 
                	             box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); animation: slideIn 0.5s ease-out; z-index: 9999;">
                	           please register as a mechanic
                	        </div>
                	        <script>
                	            window.onload = () => {
                	                const msg = document.getElementById('successMessage');
                	                if (msg) {
                	                    msg.style.display = 'block';
                	                    setTimeout(() => {
                	                        msg.style.display = 'none';
                	                    }, 5000);
                	                }
                	            };
                	        </script>
                	    """;

                	    // Write the message to the response
                	    response.getWriter().write(messageHtml);
                     	RequestDispatcher rd=request.getRequestDispatcher("/index.jsp");
                     	 rd.include(request, response);
                 	}
            	    } else if ("customer".equals(role)) {
            	      RequestDispatcher rd=request.getRequestDispatcher("/homepage.jsp");
                   	 rd.include(request, response);
            	    }  else if ("admin".equals(role)) {
            	        
            	    	if(rs3.next())
                    	{
                    		RequestDispatcher rd=request.getRequestDispatcher("/admin.jsp");
                       	 rd.include(request, response);
                    	}else {
                    		//out.print("<h2 style='color:red'> please register as a admin </h2>");
                    		response.setContentType("text/html");

                    	    String messageHtml = """
                    	        <div id="successMessage" style="display: none; position: fixed; top: 20px; right: 20px; 
                    	             background-color: #10b981; color: white; padding: 1rem 2rem; border-radius: 0.5rem; 
                    	             box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); animation: slideIn 0.5s ease-out; z-index: 9999;">
                    	           please register as a admin
                    	        </div>
                    	        <script>
                    	            window.onload = () => {
                    	                const msg = document.getElementById('successMessage');
                    	                if (msg) {
                    	                    msg.style.display = 'block';
                    	                    setTimeout(() => {
                    	                        msg.style.display = 'none';
                    	                    }, 5000);
                    	                }
                    	            };
                    	        </script>
                    	    """;

                    	    // Write the message to the response
                    	    response.getWriter().write(messageHtml);
                        	RequestDispatcher rd=request.getRequestDispatcher("/index.jsp");
                        	 rd.include(request, response);
                    	}
            	    }
            	    else {
            	    	response.setContentType("text/html");

                	    String messageHtml = """
                	        <div id="successMessage" style="display: none; position: fixed; top: 20px; right: 20px; 
                	             background-color: #10b981; color: white; padding: 1rem 2rem; border-radius: 0.5rem; 
                	             box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); animation: slideIn 0.5s ease-out; z-index: 9999;">
                	           please register your account
                	        </div>
                	        <script>
                	            window.onload = () => {
                	                const msg = document.getElementById('successMessage');
                	                if (msg) {
                	                    msg.style.display = 'block';
                	                    setTimeout(() => {
                	                        msg.style.display = 'none';
                	                    }, 5000);
                	                }
                	            };
                	        </script>
                	    """;

                	    // Write the message to the response
                	    response.getWriter().write(messageHtml);
                    	RequestDispatcher rd=request.getRequestDispatcher("/index.jsp");
                    	 rd.include(request, response);
            	    }
            	
            }else {
            	
            	 //System.out.println("MY name is jay");
            	    response.setContentType("text/html");

            	    String messageHtml = """
            	        <div id="successMessage" style="display: none; position: fixed; top: 20px; right: 20px; 
            	             background-color: #10b981; color: white; padding: 1rem 2rem; border-radius: 0.5rem; 
            	             box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); animation: slideIn 0.5s ease-out; z-index: 9999;">
            	            Email id and password didn't match
            	        </div>
            	        <script>
            	            window.onload = () => {
            	                const msg = document.getElementById('successMessage');
            	                if (msg) {
            	                    msg.style.display = 'block';
            	                    setTimeout(() => {
            	                        msg.style.display = 'none';
            	                    }, 5000);
            	                }
            	            };
            	        </script>
            	    """;

            	    // Write the message to the response
            	    response.getWriter().write(messageHtml);

            	    // Forward to the index.jsp page
            	    

            	RequestDispatcher rd=request.getRequestDispatcher("/index.jsp");
            	 rd.include(request, response);
            }
            
           
            ps = con.prepareStatement("select * from address where pincode=?");
            ps.setInt(1, rs.getInt("pincode"));  // Assuming pincode is an integer
            ResultSet rs3 = ps.executeQuery();

           
           
               
            
            
           
            
            
            
		}
		catch (ClassNotFoundException e) {
			
            e.printStackTrace();
            System.out.println("PostgreSQL JDBC driver not found");
        } catch (SQLException e) {
        	//response.setContentType("text/html");
        	out.print("<h2 style='color:red'> "+e.getMessage() +"</h2>");
        	String s1= e.getMessage();
        	response.setContentType("text/html");
            response.getWriter().write(
            	    "<div id=\"successMessage\" style=\"display: none; position: fixed; top: 20px; right: 20px; background-color: #10b981; color: white; padding: 1rem 2rem; border-radius: 0.5rem; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); animation: slideIn 0.5s ease-out; z-index: 9999; z-index: 9999;\">" +
            	    s1 +
            	    "</div>" +
            	    "<script>" +
            	    "window.onload = () => {" +
            	    "    const msg = document.getElementById('successMessage');" +
            	    "    if (msg) {" +
            	    "        msg.style.display = 'block';" +
            	    "        setTimeout(() => {" +
            	    "            msg.remove();" +
            	    "        }, 5000);" +
            	    "    }" +
            	    "};" +
            	    "</script>"
            	);  
        	RequestDispatcher rd=request.getRequestDispatcher("/index.jsp");
        	rd.include(request, response);
        }
		
}
}
