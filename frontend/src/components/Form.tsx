import React, { ChangeEvent, FormEvent, useState } from "react";
import {
  Button,
  Center,
  Flex,
  Heading,
  Textarea,
  VStack,
} from "@chakra-ui/react";

export default function Form() {
  const [content, setContent] = useState<string>();

  const handleContentChange = (event: ChangeEvent<HTMLTextAreaElement>) => {
    setContent(event.target.value);
  };

  const handleSubmit = (event: FormEvent<HTMLDivElement>) => {
    event.preventDefault();

    console.log(content);
  };

  return (
    <Center>
      <VStack direction="column" spacing="5rem">
        <Heading textAlign="center">
          Well then, don&apos;t keep your secrets :)
        </Heading>

        <Flex
          as="form"
          w="100%"
          flexDirection="column"
          alignItems="center"
          onSubmit={handleSubmit}
        >
          <Textarea
            placeholder="Write to your heart's content"
            minH="12rem"
            value={content}
            onChange={handleContentChange}
          />

          <Button type="submit" mt="1rem">
            Get Inside
          </Button>
        </Flex>
      </VStack>
    </Center>
  );
}
