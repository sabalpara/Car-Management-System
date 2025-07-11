package backand;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
@MultipartConfig
@WebServlet("/add-newcar")
public class adminAddNewCar extends jakarta.servlet.http.HttpServlet{
	private int getMaxOldCarId(Connection connection) throws SQLException {
        String sql = "SELECT MAX(car_id) FROM public.new_car";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            try (var resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1)+1;
                }
            }
        }
        return 1;
    }
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out= response.getWriter();
		try {
			
			//System.out.println("hi my name is jay");
			response.setContentType("text/html");
            Class.forName("org.postgresql.Driver");
			String url = "jdbc:postgresql://localhost:5432/postgres";
            String username = "postgres";
            String password2 = "jay";
            
            Connection con = DriverManager.getConnection(url, username, password2);
            
            String model = request.getParameter("Model");
            String company = request.getParameter("company");
            String price = request.getParameter("Price");
            String colour = request.getParameter("colour");
            String fuel = request.getParameter("fuel");
            String safety_rating = request.getParameter("safety");
            String transmission = request.getParameter("transmission");
            String warranty = request.getParameter("warranty");
            String new1="new";
            
            Part file=request.getPart("image");
            String imageFileName = file.getSubmittedFileName();
           // System.out.println("Selected Image File Name: " + imageFileName);
            String s1="image/"+imageFileName;
            // Setting the upload path
            String uploadPath = "D:/workspace/register_login/src/main/webapp/image/" + imageFileName;
           // System.out.println("Upload Path: " + uploadPath);

            try {
                FileOutputStream fos = new FileOutputStream(uploadPath);
                InputStream is = file.getInputStream();

                byte[] data = new byte[is.available()];
                is.read(data);
                fos.write(data);
                fos.close();

            } catch (Exception e) {
                e.printStackTrace();
            }

            PreparedStatement ps = con.prepareStatement("select model from car_company where model=? ");
            ps.setString(1,model);
           
            ResultSet rs=ps.executeQuery();
            
            int flag=0;
            if(rs.next())
            {
            	flag=1;
            }
            
            if(flag==0)
            {
            	 PreparedStatement ps1 = con.prepareStatement("insert into car_company values(?,?) ");
                 ps1.setString(1,model);
                 ps1.setString(2,company);
                 ps1.executeUpdate();
            }
            
            int carid=getMaxOldCarId(con);
            PreparedStatement ps2 = con.prepareStatement("insert into new_car(car_id,safety_ratings,transmission_type,warranty_year,image) values(?,?,?,?,?) ");
            ps2.setInt(1, carid);
            ps2.setInt(2, Integer.parseInt(safety_rating));
            ps2.setString(3, transmission);
            ps2.setInt(4, Integer.parseInt(warranty));
            ps2.setString(5, s1);
            
            PreparedStatement ps3 = con.prepareStatement("insert into car(car_id,price,colour,model,fuel_type,car_type,image) values(?,?,?,?,?,?,?) ");
            ps3.setInt(1, carid);
            ps3.setInt(2,Integer.parseInt(price));
            ps3.setString(3, colour);
            ps3.setString(4,model);
            ps3.setString(5, fuel);
            ps3.setString(6, new1);
            ps3.setString(7, s1);
            
            ps2.executeUpdate();
            ps3.executeUpdate();
            response.setContentType("text/html");

            // Write HTML with CSS for the success message
            response.setContentType("text/html");
            response.getWriter().write(
            	    "<div id=\"successMessage\" style=\"display: none; position: fixed; top: 20px; right: 20px; background-color:#10b981; color: white; padding: 1rem 2rem; border-radius: 0.5rem; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); animation: slideIn 0.5s ease-out; z-index: 9999; z-index: 9999;\">" +
            	    "Car listed successfully!" +
            	    "</div>" +
            	    "<script>" +
            	    "window.onload = () => {" +
            	    "    const msg = document.getElementById('successMessage');" +
            	    "    if (msg) {" +
            	    "        msg.style.display = 'block';" +
            	    "        setTimeout(() => {" +
            	    "            msg.remove();" +
            	    "        }, 10000);" +
            	    "    }" +
            	    "};" +
            	    "</script>"
            	); 
            RequestDispatcher rd=request.getRequestDispatcher("/admin.jsp");
       	    rd.include(request, response);
        	
            
            
            
            
		}
		
		catch (ClassNotFoundException e) {
		    e.printStackTrace();
		    System.out.println("PostgreSQL JDBC driver not found");
		} catch (SQLException e) {
			response.setContentType("text/html");
			out.print("<h2 style='color:red'> "+e.getMessage() +"</h2>");
			RequestDispatcher rd=request.getRequestDispatcher("/admin.jsp");
			rd.include(request, response);
		}
		
	}
}
