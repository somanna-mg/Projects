package com.tap.controller;

import com.tap.dao.RecipeDAO;
import com.tap.daoimpl.RecipeDAOImpl;
import com.tap.model.Recipe;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/index")
public class IndexServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RecipeDAO recipeDAO;

    public IndexServlet() {
        super();
        recipeDAO = new RecipeDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Recipe> recipes = recipeDAO.getAllRecipes();
        
        for (Recipe recipe : recipes) {
			System.out.println(recipe);
		}
        
        request.setAttribute("recipes", recipes);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
