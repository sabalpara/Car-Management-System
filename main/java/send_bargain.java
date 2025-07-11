package backand;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
@WebServlet("/bargainform")
public class send_bargain extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out= response.getWriter();
		try {
			
        	//out.print("hello");
			 String carId = request.getParameter("car_id");
			 String pricee = request.getParameter("amount");
			 
			 int car=Integer.parseInt(carId);
			 int price=Integer.parseInt(pricee);
			response.setContentType("text/html");
            Class.forName("org.postgresql.Driver");

            String url = "jdbc:postgresql://localhost:5432/postgres";
            String username = "postgres";
            String password2 = "jay";
            
            Connection con = DriverManager.getConnection(url, username, password2);
            PreparedStatement ps ;
            HttpSession session=request.getSession();
            
           ps=con.prepareStatement("insert into bargain_request (customer_id,car_id,price)values(?,?,?) ");
         
           ps.setInt(2, car);
           ps.setString(1,(String) session.getAttribute("email") );
           ps.setInt(3,price );
           
            
           
           ps.executeUpdate();
           response.setContentType("text/html");

           // Write HTML with CSS for the success message
           response.setContentType("text/html");
           response.getWriter().write(
           	    "<div id=\"successMessage\" style=\"display: none; position: fixed; top: 20px; right: 20px; background-color:#10b981; color: white; padding: 1rem 2rem; border-radius: 0.5rem; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); animation: slideIn 0.5s ease-out; z-index: 9999; z-index: 9999;\">" +
           	    "Request sent successfully!" +
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
            RequestDispatcher rd=request.getRequestDispatcher("/oldcar.jsp");
       	    rd.include(request, response);
        	
            
		}
		catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("PostgreSQL JDBC driver not found");
        } catch (SQLException e) {
        	response.setContentType("text/html");
        	out.print("<h2 style='color:red'> "+e.getMessage() +"</h2>");
        	RequestDispatcher rd=request.getRequestDispatcher("/index.jsp");
        	rd.include(request, response);
        }
}

}