import express from "express";

const app = express();
app.use(express.json());

let blogs = [];
let idCounter = 1;

// Create a blog
app.post("/blogs", (req, res) => {
  const { title, description } = req.body;
  if (!title || !description) {
    return res
      .status(400)
      .json({ error: "Title and description are required" });
  }
  const blog = { id: idCounter++, title, description };
  blogs.push(blog);
  res.status(201).json(blog);
});

// Read a blog by ID
app.get("/blogs/:id", (req, res) => {
  const blog = blogs.find((b) => b.id === parseInt(req.params.id));
  if (!blog) {
    return res.status(404).json({ error: "Blog not found" });
  }
  res.json(blog);
});

// Update a blog by ID
app.put("/blogs/:id", (req, res) => {
  const blog = blogs.find((b) => b.id === parseInt(req.params.id));
  if (!blog) {
    return res.status(404).json({ error: "Blog not found" });
  }
  const { title, description } = req.body;
  if (!title || !description) {
    return res
      .status(400)
      .json({ error: "Title and description are required" });
  }
  blog.title = title;
  blog.description = description;
  res.json(blog);
});

// Delete a blog by ID
app.delete("/blogs/:id", (req, res) => {
  const blogIndex = blogs.findIndex((b) => b.id === parseInt(req.params.id));
  if (blogIndex === -1) {
    return res.status(404).json({ error: "Blog not found" });
  }
  const deletedBlog = blogs.splice(blogIndex, 1);
  res.json(deletedBlog[0]);
});

const PORT = 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
