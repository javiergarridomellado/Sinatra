require "sinatra"

get '/' do
  @files = Dir.entries("bases")
  erb :home, layout: :main
  
end
get '/create' do
    erb:create, layout: :main
end

post '/create' do
    @name = params['name']
    @description = params['description']
    save_workshop(@name, @description)
    @message = "El taller fue creado exitosamente"
    erb:message, layout: :main
end
get '/:nombre' do
    @nombre = params[:nombre]
    @description = workshop_content(@nombre)
    erb :taller, layout: :main
end

delete '/:nombre' do
    delete_workshop(params[:nombre])
    @message = "El taller fue borrado exitosamente"
    erb:message, layout: :main
end

get '/:nombre/edit' do
    @nombre = params[:nombre]
    @descripcion = workshop_content(@nombre)
    erb:edit, layout: :main
end

put '/:nombre' do
    @nombre = params[:nombre]
    @description = params['description']
    save_workshop(@nombre, @description)
    redirect URI.escape("/#{params[:nombre]}")
end


get '/imagenes' do
  "<h1>Imagenes del Ciclo 2018-2019</h1>"
end

get '/contacto' do
  "<h1>Contactos del Ciclo 2018-2019</h1>"
end

def workshop_content(nombre)
    File.read("bases/#{nombre}.txt")
rescue Errno::ENOENT
    return nil
end

def save_workshop(nombre, descripcion)
    File.open("bases/#{nombre}.txt", 'w') do |file|
        file.print(descripcion)
    end    
end

def delete_workshop(nombre)
    File.delete("bases/#{nombre}.txt")    
end



