<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession, com.tap.dao.RecipeDAO, com.tap.daoimpl.RecipeDAOImpl, com.tap.model.Recipe" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Recipe - Recipe Review</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <header class="header">
        <div class="header-container">
            <a href="index" class="logo">Recipe Review</a>
            <ul class="nav-links">
                <li><a href="index">Home</a></li>
                <li><a href="search-recipes.jsp">Recipes</a></li>
                <li><a href="profile.jsp">Profile</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </div>
    </header>

    <div class="container">
        <div class="form-container fade-in">
            <h2 class="form-title">Edit Recipe</h2>

            <% 
                HttpSession session1 = request.getSession(false);
                if (session1 == null || session1.getAttribute("userId") == null) {
                    response.sendRedirect("login.jsp?message=Please login to edit your recipes.");
                    return;
                }

                String recipeIdParam = request.getParameter("recipeId");
                if (recipeIdParam == null) {
                    response.sendRedirect("view-my-recipes.jsp?message=Invalid recipe ID.");
                    return;
                }

                int recipeId = Integer.parseInt(recipeIdParam);
                RecipeDAO recipeDAO = new RecipeDAOImpl();
                Recipe recipe = recipeDAO.getRecipeById(recipeId);

                if (recipe == null || recipe.getUserId() != (int) session.getAttribute("userId")) {
                    response.sendRedirect("view-my-recipes.jsp?message=Unauthorized access.");
                    return;
                }
            %>

            <form action="edit-recipe" method="post">
                <input type="hidden" name="recipeId" value="<%= recipe.getRecipeId() %>">

                <div class="form-group">
                    <label for="title" class="form-label">Title:</label>
                    <input type="text" id="title" name="title" class="form-input" value="<%= recipe.getTitle() %>" required>
                </div>

                <div class="form-group">
                    <label for="description" class="form-label">Description:</label>
                    <textarea id="description" name="description" class="form-textarea" required><%= recipe.getDescription() %></textarea>
                </div>

                <div class="form-group">
                    <label for="ingredients" class="form-label">Ingredients:</label>
                    <textarea id="ingredients" name="ingredients" class="form-textarea" required><%= recipe.getIngredients() %></textarea>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="cuisine" class="form-label"><i class="fas fa-globe-americas"></i> Cuisine:</label>
                        <input type="text" id="cuisine" name="cuisine" class="form-input" value="<%= recipe.getCuisine() %>">
                    </div>

                    <div class="form-group">
                        <label for="category" class="form-label"><i class="fas fa-tag"></i> Category:</label>
                        <input type="text" id="category" name="category" class="form-input" value="<%= recipe.getCategory() %>">
                    </div>
                </div>

                <div class="form-group">
                    <label for="imageUrl" class="form-label"><i class="fas fa-image"></i> Image URL:</label>
                    <input type="text" id="imageUrl" name="imageUrl" class="form-input" value="<%= recipe.getImageUrl() %>">
                </div>

                <button type="submit" class="btn btn-block"><i class="fas fa-save"></i> Update Recipe</button>
            </form>

            <div class="form-footer">
                <a href="view-my-recipes.jsp" class="btn btn-secondary"><i class="fas fa-times"></i> Cancel</a>
            </div>
        </div>
    </div>
</body>
</html>