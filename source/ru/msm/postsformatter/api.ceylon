import ru.msm.conceptsexprector {
    subscribe,
    Concept,
    text
}
import ceylon.collection {
    ArrayList
}

{Concept*} enrich({Concept*} initial) {
    value result = ArrayList<Concept>();
    value sorted = initial.sort( (c1, c2) => c1.startPosition <=> c2.startPosition);
    sorted.fold(result -> 0)( ( enrichedData -> lastPosition, currentConcept) {
        if(currentConcept.startPosition > lastPosition) {
            enrichedData.add(Concept(lastPosition, currentConcept.startPosition, text));
        }
        enrichedData.add(currentConcept);
        value newCounter = currentConcept.endPositiom;
        return enrichedData -> newCounter;
    });

    return result;
}

String format(String str, {Concept*} concept) {
    return "".join(enrich(concept)
        .map( (c)
          => let (content = str.substring(c.startPosition, c.endPositiom))
             c.conceptType.format(content)
            ));
}

shared {String*} subsccribeFormatted() {
    return subscribe.map( (str -> concept) => format(str, concept));
}

shared void runAll() {
    print(subsccribeFormatted().first);
}