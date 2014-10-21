DIST = "js"
SRC = "src"

task :default => [:build]

task :build => [:clean] do 
  sh "coffee -o #{DIST} -cb #{SRC}"
end

task :watch do
  sh "coffee -o #{DIST} -wb #{SRC}"
end

task :clean do
  sh "rm -rf #{DIST}/*"
end