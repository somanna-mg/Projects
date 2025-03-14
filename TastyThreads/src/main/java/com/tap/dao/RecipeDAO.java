package com.tap.dao;

import java.util.List;

import com.tap.model.Recipe;
import com.tap.model.Review;

public interface RecipeDAO {
    // Create a new recipe
    boolean addRecipe(Recipe recipe);

    // Retrieve a recipe by ID
    Recipe getRecipeById(int recipeId);

    // Retrieve all recipes
    List<Recipe> getAllRecipes();

    // Retrieve recipes by user ID
    List<Recipe> getRecipesByUserId(int userId);

    // Update a recipe
    boolean updateRecipe(Recipe recipe);

    // Delete a recipe by ID
    boolean deleteRecipe(int recipeId);

	List<Recipe> searchRecipes(String query, String cuisine, String category, float minRating);

	List<Review> getReviewsByRecipeId(int recipeId);  // Fetch all reviews for a recipe
    
	boolean addReview(Review review);  // Add a new review
    
	float calculateAverageRating(int recipeId);
	
	
	
}
