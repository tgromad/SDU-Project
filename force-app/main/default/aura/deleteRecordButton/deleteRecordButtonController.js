({
        handleDeleteRecord: function(component, event, helper) {
        var deleteTvSerie = component.get("c.deleteTvSeries");
        var recordId = component.get("v.recordId");
        deleteTvSerie.setParams({"tvSerieId" : recordId});
            deleteTvSerie.setCallback(this, function(response) {
                var state = response.getState();
                if(state === "SUCCESS") {
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "title": "TV Serie Deleted",
                        "message": "The TV Serie is deleted."
                    });
                    $A.get("e.force:closeQuickAction").fire();
                    resultsToast.fire();
                    $A.get("e.force:navigateHome").fire();
                }
                else if (state === "ERROR") {
                    console.log('Problem delete, response state: ' + state);
                }
                else {
                    console.log('Unknown problem, response state: ' + state);
                }
            });
            $A.enqueueAction(deleteTvSerie);
        
    }
})