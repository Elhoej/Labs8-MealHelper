exports.up = function(knex) {
  return Promise.all([
    knex.schema.createTable("users", function(users) {
      users.increments("id").primary();
      users
        .string("email", 40)
        .unique()
        .notNullable();
      users.string("password", 255);
      users.integer("zip", 5);
      users.string("healthCondition", 20);
    }),
    knex.schema.createTable("mealList", function(mealList) {
      mealList.increments("id").primary();
      mealList.integer("user_id");
      mealList.foreign("user_id").references("users.id");
      mealList.string("mealTime").notNullable();
      mealList.string("experience");
      mealList.string("name").notNullable();
      mealList.float("temp").notNullable();
      mealList.float("humidity");
      mealList.float("pressure");
      mealList.string("notes");
      mealList.string("date").notNullable();
      mealList.integer("servings");
      mealList.integer("recipe_id");
      mealList.foreign("recipe_id").references("recipe.id");
    }),
    knex.schema.createTable("recipe", function(recipe) {
      recipe.increments("id").primary();
      recipe.string("name", 255).notNullable();
      recipe.integer("calories", 6).notNullable();
      recipe.integer("servings", 3).notNullable();
      recipe.integer("ingredients_id");
      recipe.foreign("ingredients_id").references("ingredients.id");
      recipe.integer("user_id");
      recipe.foreign("user_id").references("users.id");
    }),
    knex.schema.createTable("ingredients", function(ingredients) {
      ingredients.increments("id").primary();
      ingredients.integer("ndb_id");
      ingredients.string("name", 255).notNullable();
      ingredients.string("nutrients_id");
      ingredients.foreign("nutrients_id").references("nutrients.id");
      ingredients.integer("user_id");
      ingredients.foreign("user_id").references("users.id");
    }),
    knex.schema.createTable("nutrients", function(nutrients) {
      nutrients.increments("id").primary();
      nutrients.string("nutrient", 255).notNullable();
      //Explain unit convo to team
      nutrients.string("unit", 6).notNullable();
      nutrients.string("value", 6).notNullable();
      //NDBNO
      nutrients.integer("nutrients_id").notNullable();
    }),
    knex.schema.createTable("weather", function(weather) {
      weather.increments("id").primary();
      weather.string("name").notNullable();
      weather.float("temp").notNullable();
      weather.float("humidity");
      weather.float("pressure");
      weather.integer("meal_id");
      weather
        .foreign("meal_id")
        .references("mealList.id")
        .onDelete("cascade");
      weather.integer("user_id");
      weather
        .foreign("user_id")
        .references("users.id")
        .onDelete("cascade");
    }),
    knex.schema.createTable("alarms", function(alarms) {
      alarms.increments("id").primary();
      alarms.integer("beginTime").notNullable();
      alarms.integer("endTime").notNullable();
      alarms.integer("beginLimit").notNullable();
      alarms.integer("endLimit").notNullable();
      alarms.integer("repeats").notNullable();
      alarms.integer("user_id");
      alarms
        .foreign("user_id")
        .references("users.id")
        .onDelete("cascade");
    }),
    knex.schema.createTable("notes", function(notes) {
      notes.increments("id").primary();
      notes.string("notebody");
      notes.integer("meal_id");
      notes.foreign("meal_id").references("mealList.id");
    })
  ]);
};

exports.down = function(knex) {
  return Promise.all([
    knex.schema.dropTableIfExists("users"),
    knex.schema.dropTableIfExists("mealList"),
    knex.schema.dropTableIfExists("recipe"),
    knex.schema.dropTableIfExists("ingredients"),
    knex.schema.dropTableIfExists("nutrients"),
    knex.schema.dropTableIfExists("weather"),
    knex.schema.dropTableIfExists("alarms"),
    knex.schema.dropTableIfExists("notes")
  ]);
};
