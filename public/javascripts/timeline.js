function onLoad() {
   var eventSource = new Timeline.DefaultEventSource();
   var bandInfos = [
     Timeline.createBandInfo({
       eventSource:    eventSource,
       date:           Date(),
       width:          "80%",
       intervalUnit:   Timeline.DateTime.DAY,
       intervalPixels: 200
     }),
     Timeline.createBandInfo({
       overview:       true,
       eventSource:    eventSource,
       date:           Date(),
       width:          "20%",
       intervalUnit:   Timeline.DateTime.MONTH,
       intervalPixels: 200
     })
   ];
   bandInfos[1].syncWith = 0;

   bandInfos[0].highlight = true;
   bandInfos[1].highlight = true;

   tl = Timeline.create(document.getElementById("timeline"), bandInfos);
   Timeline.loadXML("/calendar/get_timeline.xml", function(xml, url) { eventSource.loadXML(xml, url); });

 }
