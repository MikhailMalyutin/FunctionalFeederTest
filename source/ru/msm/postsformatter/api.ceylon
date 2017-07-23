import ru.msm.conceptsextractor {
    subscribeFeedsAndConcepts,
    Concept,
    text,
    OOPApiContextExtractor
}
import ceylon.collection {
    ArrayList
}

shared {String*} subsccribeFormatted() {
    return subscribeFeedsAndConcepts.map( (str -> concept) => format(str, concept));
}

shared class OOPApiFormattedNews(OOPApiContextExtractor contextExtractor) {
    shared String|Finished nextFormattedNews() {
        value newsWithConceptsOrFinished = contextExtractor.nextNewsWithConcepts();
        if (is Finished newsWithConceptsOrFinished) {
            return newsWithConceptsOrFinished;
        }
        value newsText = newsWithConceptsOrFinished.news;
        value enrichedConcepts = enrich(
            newsWithConceptsOrFinished.concepts,
            newsText.size);
        return format(newsText, enrichedConcepts);
    }
}

{Concept*} enrich({Concept*} initial, Integer size) {
    value result = ArrayList<Concept>();
    value sorted = initial.sort( (c1, c2) => c1.startPosition <=> c2.startPosition);
    value res -> lastPosition = sorted.fold(result -> 0)(
        (enrichedData -> lastPosition, currentConcept) {
           if(currentConcept.startPosition > lastPosition) {
               enrichedData.add(Concept(lastPosition, currentConcept.startPosition, text));
           }
           enrichedData.add(currentConcept);
           value newCounter = currentConcept.endPositiom;
           return enrichedData -> newCounter;
        });
    if (size > lastPosition) {
        res.add(Concept(lastPosition, size, text));
    }

    return res;
}

String format(String str, {Concept*} enrichedConcepts) {
    return "".join(enrich(enrichedConcepts, str.size)
        .map( (c)
          => let (content = str.substring(c.startPosition, c.endPositiom))
             c.conceptType.format(content)
            ));
}