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

@WebServlet("/req_accept")
public class req_accept extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out= response.getWriter();
		HttpSession session=request.getSession();
		String memail=(String)session.getAttribute("email");
		String req_time = request.getParameter("req_time");
		String customer_id = request.getParameter("customer_id");
		String acc_time = request.getParameter("acc_time");
		try {
        	//out.print("hello");
			response.setContentType("text/html");
            Class.forName("org.postgresql.Driver");

            String url = "jdbc:postgresql://localhost:5432/postgres";
            String username = "postgres";
            String password2 = "jay";
            
            Connection con = DriverManager.getConnection(url, username, password2);

           
            PreparedStatement ps = con.prepareStatement("insert into service_accept (customer_id,request_time,mechanic_id,accept_time) VALUES (?,?::timestamp,?,?::timestamp)");
            
            ps.setString(1, customer_id);
            ps.setString(2, req_time);
            ps.setString(3, memail);
            ps.setString(4, acc_time);
            System.out.println("r "+req_time);
            System.out.println("a "+acc_time);
            int r=ps.executeUpdate();
            
            if(r>0) {
            	response.setContentType("text/html");
				RequestDispatcher rd=request.getRequestDispatcher("/mprofile.jsp");
				rd.include(request, response);
            }else {
            	response.setContentType("text/html");
				RequestDispatcher rd=request.getRequestDispatcher("/mprofile.jsp");
				rd.include(request, response);
            }
            
           
            
            
            
		}
		catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("PostgreSQL JDBC driver not found");
        } catch (SQLException e) {
        	//response.setContentType("text/html");
        	out.print("<h2 style='color:red'> "+e.getMessage() +"</h2>");
        	RequestDispatcher rd=request.getRequestDispatcher("/mprofile.jsp");
        	rd.include(request, response);
        }
		
}
}
