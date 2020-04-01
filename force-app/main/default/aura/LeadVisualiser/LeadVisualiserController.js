({
    mapLoaded: function(component, event, helper) {
        // Get a handle on our server-side controller methods       
        var leadsAction = component.get("c.getLeads");
        var userAction = component.get("c.getUserInfo");

        // Instantiate the user and leads objects - these are populated later
        var userInfo = {};
        var leads = {};

        // Set initial map parameters
        var map = window.L.map("map", {zoomControl: true});

        // Instantiate the map
        window.L.tileLayer("https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}",
        	{
            	attribution: "Tiles © Esri"
            }).addTo(map);

        // Set the default view of the map based on the users location
        map.locate({setView: true, maxZoom: 16});

        // Set the leads callback functionality
       	leadsAction.setCallback(
        	this,
            function(response) {
                var state = response.getState();

                // Haversine Distance is explained in the Helper
                var haversineDistance;

                if (component.isValid() && state === "SUCCESS") {  
                    // Put the user information into the leads variable                  
                    leads = response.getReturnValue();
                    component.set("v.leads", leads);

                    // Get all Leads and plot as Markers
                    for (var i = 0; i < leads.length; i++) {
                        if (leads[i].Latitude !== null && leads[i].Longitude !== null) {
                            // Calculate the Haversine Distance. Again, Haversine Distance is explained in the Helper
                            haversineDistance = helper.calculateHaversineDistance(leads[i].Latitude, leads[i].Longitude, userInfo.Base_Location__Latitude__s, userInfo.Base_Location__Longitude__s);
                            // Draw the markers on the map, with the Lead Name and calculated Distance
                            L.marker([leads[i].Latitude, leads[i].Longitude]).addTo(map)
                            	.bindPopup(leads[i].Name + "<br />Distance from your base location: " + haversineDistance + " miles");
                        }
                    }
                }
            }
        );

        // Set the user information callback functionality
        userAction.setCallback(
        	this,
            function(response) {
                var state = response.getState();

                if (component.isValid() && state === "SUCCESS") {
                    // Put the user information into the userInfo variable
                    userInfo = response.getReturnValue();
                    component.set("v.userInfo", userInfo);
               	}
            }
        );

        // Lastly, queue up the server-side calls
        $A.enqueueAction(userAction);
        $A.enqueueAction(leadsAction);
	}
})