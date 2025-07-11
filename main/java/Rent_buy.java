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
import java.time.*;
@WebServlet("/buyrentform")
public class Rent_buy extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out= response.getWriter();
		try {
			
        	//out.print("hello");
			int price= Integer.parseInt((String)request.getParameter("price"));
			 String carId = request.getParameter("car_id");
			 int car=Integer.parseInt(carId);
			 int days=Integer.parseInt(request.getParameter("rentdays"));
			response.setContentType("text/html");
            Class.forName("org.postgresql.Driver");

            String url = "jdbc:postgresql://localhost:5432/postgres";
            String username = "postgres";
            String password2 = "jay";
            
            Connection con = DriverManager.getConnection(url, username, password2);
            PreparedStatement ps ;
            HttpSession session=request.getSession();
            
            java.time.LocalDate currentDate = java.time.LocalDate.now();
            java.time.LocalDate dueDate = currentDate.plusDays(days);
            java.sql.Date sqlDueDate = java.sql.Date.valueOf(dueDate);
            
            PreparedStatement ps1=con.prepareStatement("update rental_car set availability='N' where rental_car_id=?") ;
            ps1.setInt(1, car);
            ps1.executeUpdate();

            
           ps=con.prepareStatement("insert into rent (car_id,customer_id,due_date)values(?,?,?) ");
           
         
           ps.setInt(1, car);
           ps.setString(2,(String) session.getAttribute("email") );
           ps.setDate(3, sqlDueDate);
          
           ps=con.prepareStatement("insert   into public.transaction  (amount,buyer_id,seller_id,car_type, car_id)values(?,?,?,?,?) ");
         	ps.setInt(1, price);
         	ps.setString(2,(String) session.getAttribute("email") );
         	ps.setString(3,"admin"  );
         	ps.setString(4,(String) "rent" );
         	ps.setInt(5, car);
         	ps.executeUpdate();
           
           ps.executeUpdate();
           response.setContentType("text/html");

           // Write HTML with CSS for the success message
           response.setContentType("text/html");
           response.getWriter().write(
           	    "<div id=\"successMessage\" style=\"display: none; position: fixed; top: 20px; right: 20px; background-color:#10b981; color: white; padding: 1rem 2rem; border-radius: 0.5rem; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); animation: slideIn 0.5s ease-out; z-index: 9999; z-index: 9999;\">" +
           	    "Car Rented successfully!" +
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
            RequestDispatcher rd=request.getRequestDispatcher("/Rentcar.jsp");
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