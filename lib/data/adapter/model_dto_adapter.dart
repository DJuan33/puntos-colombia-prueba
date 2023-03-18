abstract class ModelDtoAdapter<Model, Dto> {
  Model toModel(Dto dto);

  Dto toDto(Model model);
}
