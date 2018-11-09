// drop all foreign
// truncate all tables
// re-establish foreign

// NOTE: commented out truncate on seeds!

exports.seed = async function(knex, Promise) {
	await knex.schema.table("mealList", function(tbl) {
		tbl.dropForeign("recipe_id");
		tbl.dropForeign("user_id");
	});
	await knex.schema.table("ingredients", function(tbl) {
		tbl.dropForeign("user_id");
	});
	await knex.schema.table("recipe", function(tbl) {
		tbl.dropForeign("user_id");
	});
	await knex.schema.table("nutrients", function(tbl) {
		tbl.dropForeign("user_id");
	});
	await knex.schema.table("alarms", function(tbl) {
		tbl.dropForeign("user_id");
	});

	await knex.schema.table("weather", function(tbl) {
		tbl.dropForeign("meal_id");
	});

	await knex("users").truncate();
	await knex("mealList").truncate();
	await knex("ingredients").truncate();
	await knex("recipe").truncate();
	await knex("nutrients").truncate();
	await knex("alarms").truncate();
	await knex("weather").truncate();
	await knex("notes").truncate();

	await knex.schema.table("mealList", function(tbl) {
		tbl.foreign("user_id").references("users.id");
		tbl.foreign("recipe_id").references("recipe.id");
	});
	await knex.schema.table("ingredients", function(tbl) {
		tbl.foreign("user_id").references("users.id");
	});
	await knex.schema.table("recipe", function(tbl) {
		tbl.foreign("user_id").references("users.id");
	});

	await knex.schema.table("nutrients", function(tbl) {
		tbl.foreign("user_id").references("users.id");
	});
	await knex.schema.table("alarms", function(tbl) {
		tbl.foreign("user_id").references("users.id");
	});
	await knex.schema.table("weather", function(tbl) {
		tbl.foreign("meal_id").references("mealList.id");
	});

	await knex.schema.table("notes", function(tbl) {
		tbl.foreign("meal_id").references("mealList.id");
	});
};
