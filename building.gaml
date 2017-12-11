model building


global {
	//file building_shapefile <- file("../includes/building.shp");
	//geometry shape <- envelope(building_shapefile);
	int max_memory <- 5;
	
	// Each building is (200/n) x 20
	int widthX <- 200;
	int widthY <- 20;
	
	
	list<insideBuilding> availableInteriors;
}


species insideBuilding {
	int startPositionX;
	int endPositionX;
	point resource_point;
	point enter_point;
	point exit_point;
	point mid_Point;
	int posAdd;
	
	list<insideCell> availableCells;
	list<staff> availableStaff;
	
	bool isLoading;
	
	float totalSupplies;
	
	rgb lineColor;
	rgb staffColor;
	init
	{
		totalSupplies <- 0.0;
		isLoading <- false;
		lineColor <- startPositionX = 0 ? #white : #black;
		staffColor <- rgb(rnd(255),rnd(255),rnd(255));
		
		resource_point <- {startPositionX + posAdd/2, world.location.y};
		enter_point <- {startPositionX+15, world.location.y*2};
		exit_point <- {endPositionX-15, world.location.y*2};
		
		// Let them be idle at mid point, for fun
		mid_Point <- {startPositionX + posAdd/2, world.location.y};
		insideCell the_target_cell <- insideCell closest_to mid_Point;
		
		create staff number: 3 
		{
			current_cell <- one_of(myself.availableCells);
			current_cell.is_free <- false;
			remove current_cell from: myself.availableCells;
			location <- current_cell.location;
			target_cell <- the_target_cell;
			memory << current_cell;
			color <- myself.staffColor;
			
			myBuilding <- myself;
		}
		
	}
	
	reflex loadSupplies when: isLoading
	{
		//write "load me";
	}
	
	aspect default {
		//draw shape color: rgb("gray") depth: height;
		draw sphere(10) at: resource_point color: rgb("orange");	
		draw sphere(4) at: enter_point color: rgb("green");	
		draw sphere(4) at: exit_point color: rgb("red");	
		
		// Draw wall
		draw line([{startPositionX, 0}, {startPositionX, world.location.y*2}]) color: lineColor;
	}
}

species staff {
	insideCell current_cell;
	insideCell target_cell;
	list<insideCell> memory;
	rgb color;
	insideBuilding myBuilding;
	int speed <- 5;
	
	float totalCarry;
	
	// Too lazy to do FSM
	bool travelToResource;
	bool travelToDelivery;
	
	// Just chat yeye
	reflex chat when: !myBuilding.isLoading
	{
		target_cell <- insideCell closest_to myBuilding.mid_Point;
	}	
	// Move to green, someone entered
	reflex askSupplier when: myBuilding.isLoading
	{
		target_cell <- insideCell closest_to myBuilding.enter_point;
		if(self.location distance_to target_cell.location < 2)
		{
			travelToResource <- true;
		}
	}	
	
	// Move to yellow
	reflex getResource when: travelToResource//myBuilding.isLoading
	{
		target_cell <- insideCell closest_to myBuilding.resource_point;
		if(self.location distance_to target_cell.location < 2)
		{
			travelToResource <- false;
			travelToDelivery <- true;
			// Update carry 
			totalCarry <- 100.0;
		}
	}
	
	// Move to green
	reflex deliverResource when: travelToDelivery
	{
		target_cell <- insideCell closest_to myBuilding.exit_point;
		if(self.location distance_to target_cell.location < 2)
		{
			myBuilding.totalSupplies <- myBuilding.totalSupplies + totalCarry;
			totalCarry <- 0;
			travelToDelivery <- false;
		}
	}
	
	reflex move 
	{
		list<insideCell> possible_cells <- current_cell neighbours_at speed where ( not (each in memory));
		if not empty(possible_cells) and target_cell != nil {
			current_cell.is_free <- true;
			current_cell <- shuffle(possible_cells) with_min_of (each.location distance_to target_cell.location);
			location <- current_cell.location;
			current_cell.is_free <- false;
			memory << current_cell; 
			if (length(memory) > max_memory) {
				remove memory[0] from: memory;
			}
		}
	}
	
	aspect default {
		draw pyramid(4) color: color;
		draw sphere(4/3) at: {location.x,location.y,4} color: color;
	}
}

grid insideCell width: widthX height: widthY  neighbours: 8 frequency: 0 {
	bool is_obstacle <- false;
	bool is_free <- true;
	rgb color <- rgb("white");
}
