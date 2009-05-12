function onLoad() {
   var eventSource = new Timeline.DefaultEventSource();
   var bandInfos = [
    Timeline.createBandInfo({
       eventSource:    eventSource,
       date:           Date(),
       width:          "35%",
       intervalUnit:   Timeline.DateTime.HOUR,
       intervalPixels: 200
     }),
     Timeline.createBandInfo({
       eventSource:    eventSource,
       date:           Date(),
       width:          "55%",
       intervalUnit:   Timeline.DateTime.DAY,
       intervalPixels: 200
     }),
     Timeline.createBandInfo({
       overview:       true,
       eventSource:    eventSource,
       date:           Date(),
       width:          "10%",
       intervalUnit:   Timeline.DateTime.MONTH,
       intervalPixels: 300
     })
   ];
   bandInfos[1].syncWith = 0;
   bandInfos[2].syncWith = 1;

   bandInfos[0].highlight = true;
   bandInfos[1].highlight = true;
   bandInfos[2].highlight = true;

   tl = Timeline.create(document.getElementById("timeline"), bandInfos);
   Timeline.loadXML("calendar/get_timeline.xml", function(xml, url) { eventSource.loadXML(xml, url); });

 }
