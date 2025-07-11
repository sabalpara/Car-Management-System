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

import java.sql.Timestamp;
@MultipartConfig
@WebServlet("/addimage")
public class addimage extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out= response.getWriter();
		try {
			
        	//out.print("hello");
			 
			response.setContentType("text/html");
            Class.forName("org.postgresql.Driver");

            String url = "jdbc:postgresql://localhost:5432/postgres";
            String username = "postgres";
            String password2 = "jay";
            
            Connection con = DriverManager.getConnection(url, username, password2);
            PreparedStatement ps ;
            HttpSession session=request.getSession();
            
            Part file=request.getPart("image");
            String imageFileName = file.getSubmittedFileName();
            System.out.println("Selected Image File Name: " + imageFileName);
            String s1="image/"+imageFileName;
            String sql = "UPDATE public.customer SET image = ? WHERE \"Email_id\" = ?";
            ps = con.prepareStatement(sql);
            session.setAttribute("image", s1);
            // Set the values for placeholders
            ps.setString(1, s1); // Replace with actual image path or URL
            ps.setString(2, (String)session.getAttribute("email")); // Replace with actual email ID

            // Execute the update
            ps.executeUpdate();

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
            RequestDispatcher rd=request.getRequestDispatcher("/profileFile.jsp");
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