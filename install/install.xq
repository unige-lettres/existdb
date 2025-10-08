xquery version "3.1";

declare namespace file = 'http://exist-db.org/xquery/file';
declare namespace repo = 'http://exist-db.org/xquery/repo';
declare namespace sm = 'http://exist-db.org/xquery/securitymanager';
declare namespace xmldb = 'http://exist-db.org/xquery/xmldb';

let $dir := '/tmp'
let $extension := '.xar'
let $collection := '/db'
for $file in file:list($dir)/*[ends-with(@name, $extension)]
let $name := $file/@name
order by $name
let $path := $dir || '/' || $name
let $binary := file:read-binary($path)
let $path := xmldb:store($collection, $name, $binary)
let $_ := repo:install-and-deploy-from-db($path, 'https://exist-db.org/exist/apps/public-repo/find')
let $_ := xmldb:remove($collection, $name)
return $path

,

for $user in sm:find-users-by-username('')
return sm:set-account-enabled($user, false())
