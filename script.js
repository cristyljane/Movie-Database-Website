// Function to load XML or XSL file using XMLHttpRequest
function loadXMLDoc(filename) {
    var xhttp = new XMLHttpRequest();
    xhttp.open("GET", filename, false);
    xhttp.send();
    return xhttp.responseXML;
}

// Function to transform XML using XSLT and display it
function transformXML() {
    var xml = loadXMLDoc("movies.xml"); // Load XML
    var xsl = loadXMLDoc("movies.xsl"); // Load XSLT

    if (window.ActiveXObject || "ActiveXObject" in window) {
        // For older Internet Explorer versions
        var ex = xml.transformNode(xsl);
        document.getElementById("output").innerHTML = ex;
    } else if (document.implementation && document.implementation.createDocument) {
        // For modern browsers
        var xsltProcessor = new XSLTProcessor();
        xsltProcessor.importStylesheet(xsl);
        var resultDocument = xsltProcessor.transformToFragment(xml, document);
        document.getElementById("output").appendChild(resultDocument);
    }
}

function queryXML() {
    var xml = loadXMLDoc("movies.xml"); // Load XML file
    var query = document.getElementById("xpathQuery").value; // Get user input for XPath query
    var output = document.getElementById("queryOutput");
    output.innerHTML = ""; // Clear previous results

    if (!xml) {
        console.log("XML not loaded");
        output.innerHTML = "Error: XML not loaded";
        return;
    }

    try {
        // Evaluate the XPath query
        var result = xml.evaluate(query, xml, null, XPathResult.ANY_TYPE, null);
        var node = result.iterateNext();

        let hasResults = false;

        while (node) {
            hasResults = true;

            if (node.children.length > 0) {
                // If node has children, display all child elements
                let details = "";
                for (let i = 0; i < node.children.length; i++) {
                    details += node.children[i].tagName + ": " + node.children[i].textContent + "<br>";
                }
                output.innerHTML += `<p>${details}</p>`;
            } else {
                // If node has no children, display its text content
                output.innerHTML += `<p>${node.textContent}</p>`;
            }

            node = result.iterateNext();
        }

        if (!hasResults) {
            output.innerHTML = "<p style='color:red;'>No results found.</p>";
        }
    } catch (e) {
        console.log("Invalid XPath Query");
        output.innerHTML = "<p style='color:red;'>Invalid XPath Query</p>";
    }
}
