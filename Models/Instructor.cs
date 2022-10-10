namespace MVCPrototipo.Models
{
    public class Instructor
    {
        public int InstructorId {get;set;}
        public string Nombre {get;set;} = string.Empty;
        public string Apellidos {get;set;} = string.Empty;
        public string Grado {get;set;} = string.Empty;
        public byte[]? FotoPerfil {get;set;}
    }
}