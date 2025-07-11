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
@WebServlet("/newsortform")
public class newsort extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out= response.getWriter();
		String company_name=request.getParameter("search");
		
		
		try {
			int  upper=0;
			int  lower=0;
        	//out.print("hello");
			String[] selectedValues = request.getParameterValues("priceRange");
			int flag=0;
			 if (selectedValues != null) {
				 flag=1;
		            for (String value : selectedValues) {
		                if(value.equals("1")) {
		                	upper=200000;
		                	lower=100000;
		                }else if(value.equals("2")){
		                	upper=500000;
		                	lower=200001;
		                }
		                else if(value.equals("3")){
		                	upper=1000000;
		                	lower=500001;
		                }
		                else if(value.equals("4")){
		                	upper=2000000;
		                	lower=1000001;
		                }
		                else if(value.equals("5")){
		                	upper=3000000;
		                	lower=2000001;
		                }
		                else if(value.equals("6")){
		                	upper=5000000;
		                	lower=3000000;
		                }
		                else if(value.equals("7")){
		                	upper=8000000;
		                	lower=5000001;
		                }
		                else {
		                	upper=Integer.MAX_VALUE;
		                	lower=8000001;
		                }
		            }
		        }
			 if(flag==0) {
				 upper=Integer.MAX_VALUE;
             	lower=0;
			 }
          // out.println(upper);
			response.setContentType("text/html");
            Class.forName("org.postgresql.Driver");

            String url = "jdbc:postgresql://localhost:5432/postgres";
            String username = "postgres";
            String password2 = "jay";
            
            Connection con = DriverManager.getConnection(url, username, password2);
            PreparedStatement ps;
           
            if(company_name.isEmpty()) {
            	ps = con.prepareStatement("SELECT * FROM new_car_model WHERE price <= ? AND price >= ?" +
                        " AND NOT EXISTS (SELECT 1 FROM buy_newcar WHERE new_car_model.car_id = buy_newcar.car_id) " +
                        "ORDER BY car_id DESC");

                //out.println(company_name);
            	ps.setInt(1, upper);
                ps.setInt(2, lower);
            }else {
            ps = con.prepareStatement("select * from new_car_model  where (company_name ILIKE ? or model ILIKE ?) and price<=? and price>=? " +
            	    "ORDER BY car_id DESC");
            //out.println(company_name);
            ps.setString(1, "%"+company_name+"%");
            ps.setString(2, "%"+company_name+"%");
            ps.setInt(3, upper);
            ps.setInt(4, lower);
            }
            ResultSet rs=ps.executeQuery();
          
            HttpSession session=request.getSession();
            session.setAttribute("resultset",rs );
            
           
            response.setContentType("text/html");
        	
        	RequestDispatcher rd=request.getRequestDispatcher("/Newcar.jsp");
        	rd.include(request, response);
		}
		
		catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("PostgreSQL JDBC driver not found");
        } catch (SQLException e) {
        	//response.setContentType("text/html");
        	out.print("<h2 style='color:red'> "+e.getMessage() +"</h2>");
        	RequestDispatcher rd=request.getRequestDispatcher("/Newcar.jsp");
        	rd.include(request, response);
        }
		
}

}

