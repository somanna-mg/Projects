package com.tap.controller;

import com.tap.dao.RecipeDAO;
import com.tap.daoimpl.RecipeDAOImpl;
import com.tap.model.Recipe;

import java.io.IOException;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/add-recipe")
public class AddRecipeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RecipeDAO recipeDAO;

    public AddRecipeServlet() {
        super();
        recipeDAO = new RecipeDAOImpl();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Validate user session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp?message=Please login to add a recipe.");
            return;
        }

        // Get form data
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String ingredients = request.getParameter("ingredients");
        String cuisine = request.getParameter("cuisine");
        String category = request.getParameter("category");
        String imageUrl = request.getParameter("imageUrl");

        // Get the logged-in user's ID
        int userId = (int) session.getAttribute("userId");

        // Create recipe object
        Recipe recipe = new Recipe(0, title, description, ingredients, cuisine, category, userId, imageUrl, 0.0f, new Timestamp(System.currentTimeMillis()));

        // Insert recipe into the database
        boolean isAdded = recipeDAO.addRecipe(recipe);

        if (isAdded) {
            response.sendRedirect("view-my-recipes.jsp?message=Recipe added successfully!");
        } else {
            response.sendRedirect("add-recipe.jsp?message=Error adding recipe. Please try again.");
        }
    }
}
