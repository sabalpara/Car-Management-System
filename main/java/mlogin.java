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

@WebServlet("/mloginform")
public class mlogin extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out= response.getWriter();
		String email=request.getParameter("username");
		String password=request.getParameter("password");
		
		try {
        	//out.print("hello");
			response.setContentType("text/html");
            Class.forName("org.postgresql.Driver");

            String url = "jdbc:postgresql://localhost:5432/postgres";
            String username = "postgres";
            String password2 = "jay";
            
            Connection con = DriverManager.getConnection(url, username, password2);

           
            PreparedStatement ps = con.prepareStatement("select * from mechanic where mechanic_id=?");
            ps.setString(1, email);
            ResultSet rs2=ps.executeQuery();
            
            ps=con.prepareStatement("select * from customer where \"Email_id\" =?");
            ps.setString(1, email);
            ResultSet rs=ps.executeQuery();
            
            ps=con.prepareStatement("select * from phone_no where Email_id =?");
            ps.setString(1, email);
            ResultSet rs3=ps.executeQuery();
            
            HttpSession session=request.getSession();
            if(rs.next() && rs2.next() &&  rs.getString("password").equals(password)) {
            	
            	session.setAttribute("memail", email);
            	session.setAttribute("mfirst_name",rs.getString("first_name") );
            	session.setAttribute("mlast_name",rs.getString("last_name") );
            	
            	session.setAttribute("mname",rs.getString("first_name")+" "+rs.getString("last_name") );
            	session.setAttribute("mpin_code", rs.getString("pincode"));
            	session.setAttribute("marea_name", rs.getString("area_name"));
            	session.setAttribute("mapt_name", rs.getString("apt_name"));
            	session.setAttribute("mimage", rs.getString("image"));
            	
            	if (rs3.next()) {
                	//System.out.println(rs3.getInt("mobile_no"));
                    session.setAttribute("mmobile", rs3.getString("mobile_no"));
                }
                ps = con.prepareStatement("select * from address where pincode=?");
                ps.setInt(1, rs.getInt("pincode"));  // Assuming pincode is an integer
                ResultSet rs4 = ps.executeQuery();

               
                if (rs4.next()) {
                    session.setAttribute("mcity", rs4.getString("city"));
                    session.setAttribute("mstate", rs4.getString("state"));
                }
            	
            	RequestDispatcher rd=request.getRequestDispatcher("/mprofile.jsp");
            	rd.include(request, response);
            }else {
            	
            	out.print("<h2 style='color:red'> You are not a Mechanic</h2>");
            	RequestDispatcher rd=request.getRequestDispatcher("/mlogin.jsp");
            	 rd.include(request, response);
            }
            
            
            
            
            
            
		}
		catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("PostgreSQL JDBC driver not found");
        } catch (SQLException e) {
        	//response.setContentType("text/html");
        	out.print("<h2 style='color:red'> "+e.getMessage() +"</h2>");
        	RequestDispatcher rd=request.getRequestDispatcher("/mlogin.jsp");
        	rd.include(request, response);
        }
		
}
}
