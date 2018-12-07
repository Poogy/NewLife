///scr_placePlatform();
scr_basic();

maxHeightDifference = 5; //between platforms
minHeightDifference = 3; //atleast 2
minPlatformLength = 3;
minSpaceLength = 2;

heightY = 0; //At which heights the last tiles were placed

placesPerRow = rows - 2; //24
placesPerColumn = columns - 2; //17

definiteSpace = false; //If there is only one space at the border of the window
frontSpace = 0; //true = space is at the front/left || false = space is at the back/right
frontBackSpace = 0; //Variable to choose between back/front

//Place Platforms
for(h = 0; heightY < placesPerColumn - maxHeightDifference; h++){ //Choose how many Platform Levels there should be
	posY[h] = irandom_range(minHeightDifference, maxHeightDifference);
	heightY += posY[h];
	
	//Creating random platforms
	platformAmt = irandom_range(1, 3); //Choose the amount of platforms per row
	spaceBetweenPlatformModifier = irandom_range(-1,1); //To determine how a line will look / the amount of spaces

	spaces = platformAmt + spaceBetweenPlatformModifier; //(n-1, n, n+1) = (space inbetween, + at the front/back, + everywhere)
	if((spaceBetweenPlatformModifier == 0) || (spaces == 0)){frontBackSpace = irandom_range(1,2); definiteSpace = true;}
	if(frontBackSpace == 1) frontSpace = true;
	else if(frontBackSpace == 2) frontSpace = false;
	if(spaces == 0) spaces = 1; //against zero space to pass through

	//Space Length
	freeSpacePerHeightLevel = irandom_range(spaces * minSpaceLength, placesPerRow - platformAmt * minPlatformLength);
	freeSpaceLeft = freeSpacePerHeightLevel;
	spaceLength = array_create(100,0);
	for(f = 1; f <= spaces; f++){
		spaceLength[f] = irandom_range(minSpaceLength, freeSpaceLeft - minSpaceLength * (spaces - f));
		freeSpaceLeft -= spaceLength[f];
	}
	if(freeSpaceLeft > 0) spaceLength[spaces] += freeSpaceLeft; //Add leftover free space

	placesForPlatforms = placesPerRow - freeSpacePerHeightLevel;
	spacesForPlatformsLeft = placesForPlatforms;

	//Platform Length
	for(a = 1; a <= platformAmt; a++){
		platformLength[a] = irandom_range(minPlatformLength, spacesForPlatformsLeft - (platformAmt - a) * minPlatformLength);//minRange to How much is left
		spacesForPlatformsLeft -= platformLength[a];
	}
	if(spacesForPlatformsLeft > 0) platformLength[platformAmt] += spacesForPlatformsLeft; //Add leftover space to the last Platform
	
	//Platform placing
	for(a = 1; a <= platformAmt; a++){
		if(definiteSpace){
			if(frontSpace){ //0-0-0-
				posX[1] = spaceLength[1]; //Front Space
				if(platformAmt > 1) { posX[2] = posX[1] + platformLength[1] + spaceLength[2] } //Front Space
				if(platformAmt > 2) { posX[3] = posX[2] + platformLength[2] + spaceLength[3] } //Front Space
			}else{ //-0-0-0
				posX[1] = 0; //Back Space
				if(platformAmt > 1) { posX[2] = platformLength[1] + spaceLength[1] } //Back Space
				if(platformAmt > 2) { posX[3] = posX[2] + platformLength[2] + spaceLength[2] } //Back Space
			}
		}else{
			if(spaceBetweenPlatformModifier == 1){ //0-0-0-0
				posX[1] = spaceLength[1]; //Front + Back Space
				if(platformAmt > 1) { posX[2] = posX[1] + platformLength[1] + spaceLength[2] } //Front + Back Space
				if(platformAmt > 2) { posX[3] = posX[2] + platformLength[2] + spaceLength[3] } //Front + Back Space
			}else if(spaceBetweenPlatformModifier == -1){ //-0-0-
				posX[1] = 0; //No space around
				posX[2] = platformLength[1] + spaceLength[1]; //No space around
				if(platformAmt > 2) { posX[3] = posX[2] + platformLength[2] + spaceLength[2] } //No space around
			}
		}
	}
	for(nr = 1; nr <= platformAmt; nr++){
		for(l = 1; l < platformLength[nr]; l++){ //Place Platform
			instance_create_depth(16 + 32 * (posX[nr] + l), HEIGHT - 16 - 32 * heightY, 0, obj_solid);
		}
	}
}