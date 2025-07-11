package backand;

import java.io.IOException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.IOException; 
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;

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
@WebServlet("/sellcar")

public class sellcar extends HttpServlet {
	
	private int getMaxOldCarId(Connection connection) throws SQLException {
        String sql = "SELECT MAX(car_id) FROM public.old_car";
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
		response.setContentType("text/html");
		HttpSession session=request.getSession();
		
		try {
        	//out.print("hello");
			
			response.setContentType("text/html");
            Class.forName("org.postgresql.Driver");

            String url = "jdbc:postgresql://localhost:5432/postgres";
            String username = "postgres";
            String password2 = "jay";
            
            Connection con = DriverManager.getConnection(url, username, password2);
//            request.getParameterMap().forEach((key, value) -> {
//                System.out.println(key + ": " + Arrays.toString(value));
//            });
            String model = request.getParameter("model");
            //System.out.println(model);
            String company = request.getParameter("company");
            int price = Integer.parseInt(request.getParameter("price"));
            int year = Integer.parseInt(request.getParameter("year"));
            int  kilometer = Integer.parseInt(request.getParameter("kilometer"));
            String description = request.getParameter("description");
            String fuel_type = request.getParameter("fuel_type");
            String colour = request.getParameter("colour");
            Part file=request.getPart("image");
            String imageFileName = file.getSubmittedFileName();
            //System.out.println("Selected Image File Name: " + imageFileName);
            String s1="image/"+imageFileName;
            //System.out.println("jay");
            System.out.println(s1+"     "+"jay");
            // Setting the upload path
            String uploadPath = "D:/workspace/register_login/src/main/webapp/image/" + imageFileName;
           // System.out.println("Upload Path: " + uploadPath);
          //  System.out.println("hi");
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
            
            
            int car_id=getMaxOldCarId( con ) ;
            PreparedStatement ps ;
            int flag=0;
			
            PreparedStatement ps2 = con.prepareStatement("select model from car_company ");
			 ResultSet rs=ps2.executeQuery();
			// out.print("hi");
		 while(rs.next()) {
			/// out.print(rs.getString("pincode"));
			 if(rs.getString("model").equals(model)) {
				 flag=1;
				//out.print("hi");
				 break;
				 
			 }
		 }
		 if(flag==0) {
            ps=con.prepareStatement("insert into car_company ( model,company_name)values(?,?) ");
            
            ps.setString(1, model);
            ps.setString(2, company);
            ps.executeUpdate();
		 }
            ps=con.prepareStatement("insert into old_car ( car_id, year , km,  description,seller_id,image)values(?,?,?,?,?,?) ");
            
            ps.setInt(1, car_id);
            ps.setInt(2, year);
            ps.setInt(3, kilometer);
            ps.setString(4, description);
            ps.setString(5, (String)session.getAttribute("email"));
            ps.setString(6,s1 );
          
            ps.executeUpdate();
            
            ps=con.prepareStatement("insert into car ( car_id, price , colour,  model,fuel_type,car_type,image)values(?,?,?,?,?,?,?) ");
            ps.setInt(1, car_id);
            ps.setInt(2, price);
            ps.setString(3, colour);
            ps.setString(4, model);
            ps.setString(5, fuel_type);
            ps.setString(6, "old");
            ps.setString(7,s1 );
            ps.executeUpdate();
            response.setContentType("text/html");

            // Write HTML with CSS for the success message
            response.setContentType("text/html");
            response.getWriter().write(
            	    "<div id=\"successMessage\" style=\"display: none; position: fixed; top: 20px; right: 20px; background-color: var(--success); color: white; padding: 1rem 2rem; border-radius: 0.5rem; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); animation: slideIn 0.5s ease-out; z-index: 9999; z-index: 9999;\">" +
            	    "Car listed successfully!" +
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
            	);            RequestDispatcher rd=request.getRequestDispatcher("/sell_car.jsp");
       	 rd.include(request, response);
		}
		catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("PostgreSQL JDBC driver not found");
        } catch (SQLException e) {
        	//response.setContentType("text/html");
        	out.print("<h2 style='color:red'> "+e.getMessage() +"</h2>");
        	RequestDispatcher rd=request.getRequestDispatcher("/index.jsp");
        	rd.include(request, response);
        }

	
	
	}

}
