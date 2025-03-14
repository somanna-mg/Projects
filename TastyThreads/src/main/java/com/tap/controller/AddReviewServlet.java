package com.tap.controller;

import com.tap.dao.ReviewDAO;
import com.tap.daoimpl.ReviewDAOImpl;
import com.tap.model.Review;

import java.io.IOException;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/add-review")
public class AddReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReviewDAO reviewDAO;

    public AddReviewServlet() {
        super();
        reviewDAO = new ReviewDAOImpl();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp?message=Please login to submit a review.");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int recipeId = Integer.parseInt(request.getParameter("recipeId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        Review review = new Review(0, recipeId, userId, rating, comment, new Timestamp(System.currentTimeMillis()));
        reviewDAO.addReview(review);

        response.sendRedirect("view-recipe.jsp?recipeId=" + recipeId);
    }
}
