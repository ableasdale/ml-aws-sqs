xquery version "1.0-ml";

declare function local:table() as element(table) {
    <table style="table-layout: fixed; word-wrap: break-word;" class="table table-striped table-bordered">
        <thead>
            <tr><th class="col-md-2">Message Id</th><th>Body</th></tr>
        </thead>
        <tbody></tbody>
    </table>
};

declare function local:create-bootstrap-page($title as xs:string, $content as element()){
  element html { attribute lang {"en"},
    element head {
      element meta { attribute charset {"utf-8"}},
      element meta { attribute http-equiv {"X-UA-Compatible"}, attribute content {"IE=edge"} },
      element meta { attribute name {"viewport"}, attribute content {"width=device-width, initial-scale=1"} },
      element title {$title},
      element link {
        attribute rel {"stylesheet"},
        attribute href {"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"},
        attribute integrity {"sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"},
        attribute crossorigin {"anonymous"}
      },
      element link {
        attribute rel {"stylesheet"},
        attribute href {"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css"},
        attribute integrity {"sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"},
        attribute crossorigin {"anonymous"}
      }
    },
    element body {
      $content,
      <script src="https://sdk.amazonaws.com/js/aws-sdk-2.7.13.min.js">{" "}</script>,
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.21.0/codemirror.min.css" />,
      <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.21.0/codemirror.min.js">{" "}</script>,
      <script src="http://code.jquery.com/jquery-1.12.4.min.js">{" "}</script>,
      <script src="/config.js">{" "}</script>,
      <script src="/aws-sqs.js">{" "}</script>,
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous">{" "}</script>,
      <script type="text/javascript"><![CDATA[
      // $( document ).ready(function() { setTimeout(tryToGetMessage(), 5000); });    
      $( document ).ready(function() {  setInterval(function(){ tryToGetMessage() }, 1500); });   
      ]]></script>
    }
  }
};

(: Main :)
xdmp:set-response-content-type("text/html; charset=utf-8"),
'<!DOCTYPE html>',
local:create-bootstrap-page("MarkLogic Telemetry SQS Demo", 
    element div {attribute class {"container"}, 
        element h2 {"MarkLogic ", element small {"AWS SQS Demo"}}, 
        local:table()   
    })

